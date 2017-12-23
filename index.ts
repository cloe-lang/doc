import $ = require("cash-dom");
import hljs = require("highlight.js");

import "./index.scss";

hljs.initHighlightingOnLoad();

$('a[href^="http://"], a[href^="https://"]').attr("target", "_blank");

$("a").on("mouseover", function() {
    $("head").append($("<link/>").attr({ rel: "prerender", href: $(this).attr("href") }));
});
