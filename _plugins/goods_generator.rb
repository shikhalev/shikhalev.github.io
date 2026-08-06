require 'date'

class DataMaker

  attr_reader :page, :site

  def initialize site, page
    @site = site
    @page = page
    @flat = @site.data['flat_goods']
  end

  def add_design design
    selected = @flat.select { |good| design.relative_path == good['design'] }
    selected.each { |good| good['order'] = ((good['date']&.to_date&.ld || 0) % 5000) * 1000 }
    @goods += selected
    @goods.uniq! { |g| g['url'] }
    if design.data['children']
      design.data['children'].each do |child|
        child_design = site.collections['designs'].docs.find { |d| d.relative_path == child }
        add_design child_design if child_design
      end
    end
    # @goods.shuffle!
  end

  def add_design_kind kind
    kind_title = case kind.data['shop']
    when 'printdirect'
      kind.data['title'] + ' • [pd]'
    when 'vsemayki'
      kind.data['title'] + ' • [vm]'
    when 'fun'
      kind.data['title'] + ' • [fn]'
    else
      kind.data['title']
    end
    result = {
      'count' => 1,
      'path' => kind.relative_path,
      'title' => kind_title,
      'children' => []
    }
    path = kind.relative_path
    if @kinds[path]
      @kinds[path]['count'] += 1
      return @kinds[path]
    end
    parent_kinds = site.collections['goods'].docs.select { |k| k.data['children']&.include?(path) || k.data['links']&.include?(path) }
    if parent_kinds.empty?
      result['root'] = true
    else
      parents = parent_kinds.map { |p| add_design_kind p }
      parents.each do |p|
        p['children'] << path
        p['children'].uniq!
      end
    end
    @kinds[path] = result
    if result['root']
      @kinds['@root'] = result
    end
    return result
  end

  def apply_for_design
    @goods = []
    @kinds = {}
    add_design @page
    @page.data['goods'] = @goods.sort_by { it['date'] }.reverse
    @goods.sort_by { it['good'] }.each do |good|
      kind_path = good['good']
      kind = site.collections['goods'].docs.find { |k| k.relative_path == kind_path }
      raise RuntimeError, "Good not found: #{ kind_path.inspect }" unless kind
      add_design_kind kind
    end
    @page.data['kinds'] = @kinds
  end

  def add_kind kind
    selected = @flat.select { |good| kind.relative_path == good['good'] }
    @goods += selected
    @goods.uniq! { |g| g['url'] }
    if kind.data['children']
      kind.data['children'].each do |child|
        child_kind = site.collections['goods'].docs.find { |k| k.relative_path == child }
        add_kind child_kind if child_kind
      end
    end
    if kind.data['links']
      kind.data['links'].each do |link|
        link_kind = site.collections['goods'].docs.find { |k| k.relative_path == link }
        add_kind link_kind if link_kind
      end
    end
    # @goods.shuffle!
  end

  def add_kind_design design
    result = {
      'count' => 1,
      'path' => design.relative_path,
      'title' => design.data['title'],
      'children' => []
    }
    path = design.relative_path
    if @designs[path]
      @designs[path]['count'] += 1
      return @designs[path]
    end
    parent_designs = site.collections['designs'].docs.select { |d| d.data['children']&.include?(path) }
    if parent_designs.empty?
      result['root'] = true
    else
      parents = parent_designs.map { |p| add_kind_design p }
      parents.each do |p|
        p['children'] << path
        p['children'].uniq!
      end
    end
    @designs[path] = result
    if result['root']
      @designs['@root'] = result
    end
    return result
  end

  def apply_for_kind
    @goods = []
    @designs = {}
    add_kind @page
    @page.data['goods'] = @goods.sort_by { it['date'] }.reverse
    @goods.sort_by { it['design'] }.each do |good|
      design_path = good['design']
      design = site.collections['designs'].docs.find { |d| d.relative_path == design_path }
      raise RuntimeError, "Design not found: #{ design_path.inspect }" unless design
      add_kind_design design
    end
    @page.data['designs'] = @designs
  end

end

module Jekyll

  class GoodsGenerator < Generator

    safe true
    priority :high

    SOURCE = 'goods'

    def generate site
      generate_flat site
      generate_pages site
    end

    private

    def generate_pages site
      site.collections['designs'].docs.each do |page|
        maker = DataMaker::new site, page
        maker.apply_for_design
      end
      site.collections['goods'].docs.each do |page|
        maker = DataMaker::new site, page
        maker.apply_for_kind
      end
    end

    def generate_flat site
      flattened = []
      source = site.data[SOURCE]
      process_data_node source, flattened if source
      site.data['flat_goods'] = flattened
    end

    def process_data_node node, flattened
      case node
      when Hash
        if node.key?('items') && node['items'].is_a?(Array)
          common_data = node.reject { |k, _| k == 'items' }
          node['items'].each do |item|
            if item.is_a?(Hash)
              flattened << common_data.merge(item)
            end
          end
        else
          node.each_value { |sub| process_data_node sub, flattened }
        end
      when Array
        node.each { |sub| process_data_node sub, flattened }
      end
    end

  end

end
