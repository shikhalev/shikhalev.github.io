
require 'date'
require 'json'
require 'jekyll'

class Jekyll::RecommendsGenerator < Jekyll::Generator

  safe false
  priority :low

  def generate site
    recs_json = generate_recommends_json(site)
    recs_name = make_filename('recommends', recs_json)
    site.static_files << IS::StaticFile::new(site, '/', recs_name, content: recs_json)
    site.config['recommends_json_filename'] = recs_name

    best_json = generate_bests_json(site)
    best_name = make_filename('bests', best_json)
    site.static_files << IS::StaticFile::new(site, '/', best_name, content: best_json)
    site.config['bests_json_filename'] = best_name

    good_json = generate_goods_json(site)
    good_name = make_filename('recommended-goods', good_json)
    site.static_files << IS::StaticFile::new(site, '/', good_name, content: good_json)
    site.config['recommended_goods_filename'] = good_name
  end

  private

  def transform_image site, page, source
    context = JekyllIS::Images::Context[site, page]
    width = context.config('recommends', 'width') || 340
    height = context.config('recommends', 'width') || 180
    crop = context.config('recommends', 'crop') || context.config('seo_image', 'crop')
    params = { width:, height:, format: 'webp', fit: 'cover' }
    params[:crop] = crop if crop
    result = JekyllIS::Images::Image::transform context, source, **params
    result.url
  end

  def generate_recommends_json site
    data = site.posts.docs.select { it.data['recommend'] } || []
    data.map do |post|
      item = {}
      item['title'] = post.data['title']
      item['image'] = transform_image(site, post, post.data['image'])
      item['date'] = post.date.is_a?(Date) || post.date.is_a?(Time) ? post.date.strftime('%Y / %m / %d') : post.date
      item['url'] = post.url
      item['categories'] = post.data['categories']
      item
    end.to_json
  end

  def generate_bests_json site
    data = site.categories['best'] || []
    data.map do |post|
      item = {}
      item['title'] = post.data['title']
      item['image'] = transform_image(site, post, post.data['image'])
      item['date'] = post.date.is_a?(Date) || post.date.is_a?(Time) ? post.date.strftime('%Y / %m / %d') : post.date
      item['url'] = post.url
      item
    end.to_json
  end

  def transform_good_image site, source
    @fake_page ||= site.documents.find { it.relative_path == '_designs/merch.md' }
    context = JekyllIS::Images::Context[site, @fake_page]
    width = context.config('recommends', 'good_width') || 180
    height = context.config('recommends', 'good_height') || 180
    params = { width:, height:, format: 'webp', fit: 'contain' }
    result = JekyllIS::Images::Image::Transform::transform context, source, **params
    result.url
  end

  def generate_goods_json site
    data = site.data['flat_goods'].select { it['recommend'] } || []
    if data.size < 10
      data += site.data['flat_goods'].last(10 - data.size)
    end
    data.map do |good|
      item = {}
      gd_page = site.documents.find { it.relative_path == good['good'] }
      dg_page = site.documents.find { it.relative_path == good['design'] }
      item['good'] = gd_page&.data['title']
      item['good_link'] = gd_page&.url
      item['design'] = dg_page&.data['title']
      item['design_link'] = dg_page&.url
      item['image'] = transform_good_image(site, good['img'])
      item['url'] = good['url']
      item
    end.to_json
  end

  def make_filename prefix, json
    "/data/#{ prefix }.json"
  end

end
