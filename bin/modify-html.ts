import fs = require("fs");
import htmlMinifier = require("html-minifier");
import jquery = require("jquery");
import jsdom = require("jsdom");
import util = require("util");

function createTOC($, parentNode): string {
    const tagName = parentNode.prop("tagName");
    const children = parentNode.nextUntil(tagName).filter(`h${parseInt(tagName[1], 10) + 1}`).toArray();

    if (children.length === 0) {
        return "";
    }

    const entry = (node): string => (`
        <li>
            <a href="#${$(node).attr("id")}">${$("<div>").text($(node).text()).html()}</a>
            ${createTOC($, $(node))}
        </li>`);

    return `<ul>${children.map(entry).join("")}</ul>`;
}

process.argv.slice(2).map(async (filename) => {
    const { window } = new jsdom.JSDOM(await util.promisify(fs.readFile)(filename, "utf8"));
    const $ = jquery(window);

    $('a[href^="http://"], a[href^="https://"]').attr({
        rel: "noopener", // Prevent tabnabbing.
        target: "_blank",
    });
    $("code").addClass("highlight");
    $("pre").removeClass("highlight");

    const unwrap = function() {
        $(this).parent().replaceWith($(this).children());
    };

    $("div.highlight").each(unwrap);
    $("div.highlighter-rouge").each(unwrap);
    $("h2").first().before(createTOC($, $("h1")));

    for (const attribute of ["height", "width"]) {
        $("svg.octicon").removeAttr(attribute);
    }

    $("a").each(function() {
        const path = $(this).attr("href");

        if (filename.match(`_site${path}/?index\\.html$`) ||
            filename.match(`_site${path}(\\.html)?$`)) {
            $(this).addClass("current");
        }
    });

    await util.promisify(fs.writeFile)(
        filename,
        htmlMinifier.minify(window.document.documentElement.outerHTML, {
            collapseWhitespace: true,
            minifyJS: true,
            minifyURLs: true,
        }));
});
