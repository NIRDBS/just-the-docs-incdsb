(() => {
  const links = Array.from(document.querySelectorAll(".gallery-card a"));
  if (!links.length) return;

  const overlay = document.createElement("div");
  overlay.className = "gallery-lightbox";
  overlay.innerHTML = `
    <button class="gallery-lightbox__close" aria-label="Inchide">&times;</button>
    <div class="gallery-lightbox__frame" role="dialog" aria-modal="true">
      <img class="gallery-lightbox__image" alt="">
      <div class="gallery-lightbox__caption"></div>
    </div>
  `;
  document.body.appendChild(overlay);

  const image = overlay.querySelector(".gallery-lightbox__image");
  const caption = overlay.querySelector(".gallery-lightbox__caption");
  const closeButton = overlay.querySelector(".gallery-lightbox__close");

  const open = (link) => {
    const img = link.querySelector("img");
    image.src = link.getAttribute("href");
    image.alt = img ? img.alt : "";
    caption.textContent = img ? img.alt : "";
    overlay.classList.add("is-open");
    document.body.style.overflow = "hidden";
  };

  const close = () => {
    overlay.classList.remove("is-open");
    image.src = "";
    document.body.style.overflow = "";
  };

  links.forEach((link) => {
    link.addEventListener("click", (event) => {
      event.preventDefault();
      open(link);
    });
  });

  overlay.addEventListener("click", (event) => {
    if (event.target === overlay) {
      close();
    }
  });

  closeButton.addEventListener("click", close);
  document.addEventListener("keydown", (event) => {
    if (event.key === "Escape") {
      close();
    }
  });
})();
