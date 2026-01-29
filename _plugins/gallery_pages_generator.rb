module Jekyll
  class GalleryPagesGenerator < Generator
    safe true
    priority :low

    IMAGE_EXTENSIONS = %w[.jpg .jpeg .png .gif .webp].freeze

    def generate(site)
      config = site.config.fetch("gallery", {})
      return unless config["generate_pages"]

      page_path = (config["page_path"] || "galerie").to_s
      page_layout = (config["page_layout"] || "gallery").to_s
      title_prefix = (config["page_title_prefix"] || "Galerie").to_s
      gallery_folder = (config["folder"] || "photos").to_s

      gallery_names = gallery_names_from_files(site.static_files, gallery_folder)
      gallery_names.each do |gallery_name|
        site.pages << build_page(site, page_path, page_layout, title_prefix, gallery_name)
      end
    end

    private

    def gallery_names_from_files(static_files, gallery_folder)
      folder_token = "/#{gallery_folder}/"
      static_files.filter_map do |file|
        next unless file.path.include?(folder_token)
        next if file.path.include?("/thumbs/")
        next unless IMAGE_EXTENSIONS.include?(file.extname.downcase)

        relative = file.path.split(folder_token)[1]
        next unless relative

        segments = relative.split("/")
        next if segments.length < 2

        segments.first
      end.uniq.sort
    end

    def build_page(site, page_path, page_layout, title_prefix, gallery_name)
      page = PageWithoutAFile.new(site, site.source, File.join(page_path, gallery_name), "index.html")
      page.data["layout"] = page_layout
      page.data["title"] = build_title(title_prefix, gallery_name)
      page.data["gallery"] = gallery_name
      page
    end

    def build_title(prefix, gallery_name)
      human = gallery_name.tr("_-", "  ").split.map(&:capitalize).join(" ").strip
      [prefix, human].reject(&:empty?).join(" ")
    end
  end
end
