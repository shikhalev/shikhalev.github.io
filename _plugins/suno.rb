Jekyll::Hooks::register :site, :post_read do |site|
  tracks = site.data['suno']['tracks']
  paths = tracks.map { it['lyrics'] } + tracks.map { it['original'] }
  paths = paths.compact.uniq
  paths.each do |path|
    page = (site.documents + site.pages).find { it.relative_path == path }
    if page
      if page.data['categories']
        page.data['categories'] << 'suno' if !page.data['categories'].include?('suno')
      else
        page.data['categories'] = [ 'suno' ]
      end
    end
  end
end
