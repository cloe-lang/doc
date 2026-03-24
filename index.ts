import "./index.scss";

const toc = document.querySelector(".toc");
const content = document.querySelector(".content");

if (!toc || !content) {
  throw new Error("Missing elements");
}

const centerToc = () => toc.querySelector(".current")?.scrollIntoView({ block: "center" });

document.querySelector(".menu-button")?.addEventListener("click", function (this: Element) {
  this.classList.toggle("on");
  toc.classList.toggle("hidden");
  content.classList.toggle("hidden");
  centerToc();
});

centerToc();

const link = document.querySelector('link[rel="prerender"]');

if (!link) {
  throw new Error("Missing link element");
}

for (const element of Array.from(document.getElementsByTagName("a"))) {
  element.addEventListener("mouseover", function () {
    link.setAttribute("href", this.getAttribute("href") ?? "");
  });
}
