import "./index.scss";

const toc = document.querySelector(".toc");
const content = document.querySelector(".content");

function centerToc() {
  toc.querySelector(".current").scrollIntoView({ block: "center" });
}

document.querySelector(".menu-button").addEventListener("click", function() {
  this.classList.toggle("on");
  toc.classList.toggle("hidden");
  content.classList.toggle("hidden");
  centerToc();
});

centerToc();

const link = document.querySelector('link[rel="prerender"]');

for (const element of Array.from(document.getElementsByTagName("a"))) {
  element.addEventListener("mouseover", function() {
    link.setAttribute("href", this.getAttribute("href"));
  });
}

if ("serviceWorker" in navigator) {
  navigator.serviceWorker.register("/service-worker.js");
}
