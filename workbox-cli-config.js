module.exports = {
  globDirectory: "_site",
  globPatterns: ["**/*"],
  swDest: "_site/service-worker.js",
  templatedUrls: {
    "/": "_site/index.html"
  }
};
