import * as fs from "fs";
import htmlMinifier from "html-minifier";
import jquery from "jquery";
import { JSDOM } from "jsdom";
import * as util from "util";

function createToc($: JQueryStatic, parentNode: JQuery): string {
  const tagName = parentNode.prop("tagName");
  const children = parentNode
    .nextUntil(tagName)
    .filter(`h${parseInt(tagName[1], 10) + 1}`)
    .toArray();

  if (children.length === 0) {
    return "";
  }

  const entry = (node: HTMLElement): string => {
    const id = node.textContent.toLowerCase().replace(/( |,)+/g, "-");

    $(node).attr("id", id);

    return `
      <li>
        <a href="#${encodeURI(id)}">
          ${$("<div>").text($(node).text()).html()}
        </a>
        ${createToc($, $(node))}
      </li>
    `;
  };

  return `<ul>${children.map(entry).join("")}</ul>`;
}

process.argv.slice(2).map(async (filename) => {
  const { window } = new JSDOM(
    await util.promisify(fs.readFile)(filename, "utf8")
  );
  const $ = jquery(window) as unknown as JQueryStatic;

  $('a[href^="http://"], a[href^="https://"]').attr({
    rel: "noopener", // Prevent tabnabbing.
    target: "_blank",
  });

  $("h2")
    .first()
    .before(createToc($, $("h1")));

  for (const attribute of ["height", "width"]) {
    $("svg.octicon").removeAttr(attribute);
  }

  $(".toc a").each(function () {
    const path = $(this).attr("href");

    if (
      filename.match(`_site${path}/?index\\.html$`) ||
      filename.match(`_site${path}(\\.html)?$`)
    ) {
      $(this).addClass("current");
    }
  });

  await util.promisify(fs.writeFile)(
    filename,
    htmlMinifier.minify(
      "<!DOCTYPE html>" + window.document.documentElement.outerHTML,
      {
        collapseWhitespace: true,
        minifyJS: true,
        minifyURLs: true,
        removeAttributeQuotes: true,
      }
    )
  );
});
