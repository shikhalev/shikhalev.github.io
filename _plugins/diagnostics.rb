
require 'date'
require 'time'

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
      recs, recs_count = recommendations
      bsts, bsts_count = bests
      self.content = <<~MD
        ## Рекомендации без картинки

        #{ recs }

        + **Всего: #{ recs_count }**

        ## Избранное без картинки

        #{ bsts }

        + **Всего: #{ bsts_count }**

      MD
    end

    private

    def no_image page
      image = page['image']
      image.nil? || image.empty? || image == '_src/IMG_2774.jpg'
    end

    def recommendations
      vals = @site.posts.docs.select { it.data['recommend'] }.select { no_image(it) }.map do |post|
        date = post.date
        if date.is_a?(Time) || date.is_a?(Date)
          date = date.strftime '%Y'
        end
        "+ [#{ post.data['title'] }](#{ post.url }) // #{ date }"
      end.to_a
      [ vals.join("\n\n"), vals.size ]
    end

    def bests
      vals = @site.categories['best'].select { no_image(it) }.map do |post|
        date = post.date
        if date.is_a?(Time) || date.is_a?(Date)
          date = date.strftime '%Y'
        end
        "+ [#{ post.data['title'] }](#{ post.url }) // #{ date }"
      end.to_a
      [ vals.join("\n\n"), vals.size ]
    end

  end

end
