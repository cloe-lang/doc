import $ = require("cash-dom");
import hljs = require("highlight.js");

import "./index.scss";

hljs.initHighlightingOnLoad();

$('a[href^="http://"], a[href^="https://"]').attr("target", "_blank");

$("a").on("mouseover", function() {
    $('head link[rel="prerender"]').attr("href", $(this).attr("href"));
});

$("div.menu-button").on("click", function() {
    $(this).toggleClass("on");
    $("div.toc").toggleClass("shown");
    $("div.content").toggleClass("hidden");
});
