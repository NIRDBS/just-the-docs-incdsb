# Gallery + Lightbox additions

## New files
- `_layouts/gallery.html`: New gallery layout. Builds gallery groups from `site.static_files`, supports `site.gallery` options (folder, captions, nav), and `page.gallery` for single-gallery view. Adds the gallery grid markup and styles plus a `show_title` flag to hide gallery block `<h2>` titles.
- `galerie.markdown`: New page using `layout: gallery` for an all-galleries view.
- `assets/gallery/lightbox.css`: Styles for the lightbox overlay, frame, image, caption, and close button.
- `assets/gallery/lightbox.js`: Lightbox behavior for gallery images (open, close, escape key, backdrop click).
- `_includes/head_custom.html`: Injects `assets/gallery/lightbox.css`.
- `_includes/footer_custom.html`: Injects `assets/gallery/lightbox.js`.
- `_plugins/gallery_pages_generator.rb`: Jekyll generator for per-gallery pages when `gallery.generate_pages` is enabled, using `gallery.folder` and `gallery.page_*` config options.

## Existing files changed
- `_config.yml`: Added `gallery` config section with:
  - `captions`: toggle for gallery captions.
  - `generate_pages`: toggle for auto-generated per-gallery pages.
  - `folder`: folder containing images (default `photos`).
  - `nav`: toggle for gallery navigation links.
  - `page_path`, `page_layout`, `page_title_prefix`: settings for auto-generated pages.


```
  gallery:
    captions: false
    generate_pages: false
    folder: "photos"
    nav: false
    page_path: "galerie"
    page_layout: "gallery"
    page_title_prefix: "Galerie"
  ```