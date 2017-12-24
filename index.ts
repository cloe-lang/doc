import $ = require("cash-dom");

import "./index.scss";

$('a[href^="http://"], a[href^="https://"]').attr("target", "_blank");

$("a").on("mouseover", function() {
    $('head link[rel="prerender"]').attr("href", $(this).attr("href"));
});

$("div.menu-button").on("click", function() {
    $(this).toggleClass("on");
    $("div.toc").toggleClass("shown");
    $("div.content").toggleClass("hidden");
});
