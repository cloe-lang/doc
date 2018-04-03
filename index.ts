import $ = require("cash-dom");

import "./index.scss";

$("a").on("mouseover", function() {
    $('head link[rel="prerender"]').attr("href", $(this).attr("href"));
});

$("div.menu-button").on("click", function() {
    $(this).toggleClass("on");
    $("div.toc").toggleClass("hidden");
    $("div.content").toggleClass("hidden");
});
