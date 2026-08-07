
class DiagnosticReport < Jekyll::Generator

  safe true
  priority :high

  def generate site
    return if Jekyll.env == 'production'
    path = 'admin'
    name = 'report.md'
    site.pages << Report::new(site, site.source, path, name)
  end

  class Report < Jekyll::Page

    def initialize site, base, path, name
      @site = site
      @base = base
      @dir  = path
      @name = name
      self.process name
      self.data = {
        'layout' => 'nova/page',
        'title' => 'Диагностический отчет'
      }
      self.content = <<~MD
        ## Рекомендации без картинки

        #{ recommendations }

        ## Избранное без картинки

        #{ bests }

      MD
    end

    private

    def no_image page
      image = page['image']
      image.nil? || image.empty? || image == '_src/IMG_2774.jpg'
    end

    def recommendations
      @site.posts.docs.select { it.data['recommend'] }.select { no_image(it) }.map do |post|
        "+ [#{ post.data['title'] }](#{ post.url })"
      end.join "\n\n"
    end

    def bests
      @site.categories['best'].select { no_image(it) }.map do |post|
        "+ [#{ post.data['title'] }](#{ post.url })"
      end.join "\n\n"
    end

  end

end
