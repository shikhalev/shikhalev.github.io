
module Local

  class AllVerses < Jekyll::Generator

    def generate site
      env = ENV['JEKYLL_ENV'] || 'development'
      return unless env == 'development'

      posts = site.categories['verses']&.sort_by(&:date)
      return unless posts
      content = ''
      current_year = nil
      posts.each do |post|
        if post.date.year != current_year
          current_year = post.date.year
          content << '## ' + current_year.to_s + "\n\n"
        end
        caption = post.data['caption'] || post.data['title']
        content << '### ' + caption + "\n\n"
        content << post.content + "\n\n"
        content << post.date.strftime('%d.%m.%Y') + "\n\n"
        content << "-----\n\n"
      end

      file = Jekyll::PageWithoutAFile.new(site, site.source, '', 'all_verses.txt')
      file.data['layout'] = nil
      file.content = content
      site.pages << file
    end

  end

end
