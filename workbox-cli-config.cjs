module.exports = {
  globDirectory: "_site",
  globPatterns: ["**/*"],
  swDest: "_site/service-worker.js",
  templatedURLs: {
    "/": "_site/index.html"
  }
};
