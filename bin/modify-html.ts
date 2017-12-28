import fs = require("fs");
import jquery = require("jquery");
import jsdom = require("jsdom");

process.argv.slice(2).map((filename) => {
    fs.readFile(filename, "utf8", (error, data) => {
        if (error) {
            throw error;
        }

        const { window } = new jsdom.JSDOM(data);
        const $ = jquery(window);

        $('a[href^="http://"], a[href^="https://"]').attr("target", "_blank");
        $("code").addClass("highlight");
        $("pre").removeClass("highlight");

        const unwrap = function() {
            $(this).parent().replaceWith($(this).children());
        };

        $("div.highlight").each(unwrap);
        $("div.highlighter-rouge").each(unwrap);

        fs.writeFile(filename, window.document.documentElement.outerHTML, (error) => {
            if (error) {
                throw error;
            }
        });
    });
});
