import fs = require("fs");
import jquery = require("jquery");
import jsdom = require("jsdom");
import util = require("util");

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

    await util.promisify(fs.writeFile)(filename, window.document.documentElement.outerHTML);
});
