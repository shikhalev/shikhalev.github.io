

# class DataMaker

#   attr_reader :page, :site

#   def initialize page
#     @page = page
#     @site = page.site
#     @flat = @site.data['flat_goods']
#   end

#   def add_design design
#     selected = @flat.select { |good| design.relative_path == good['design'] }
#     @goods += selected
#     @goods.uniq! { |g| g['url'] }
#     if design.data['children']
#       design.data['children'].each do |child|
#         child_design = site.collections['designs'].docs.find { |d| d.relative_path == child }
#         add_design child_design if child_design
#       end
#     end
#   end

#   def add_design_kind kind
#     result = {
#       'count' => 1,
#       'children' => []
#     }
#     path = kind.relative_path
#     if @kinds[path]
#       @kinds[path]['count'] += 1
#       return @kinds[path]
#     end
#     parent_kinds = site.collections['goods'].docs.select { |k| k.data['children']&.include?(path) || k.data['links']&.include?(path) }
#     if parent_kinds.empty?
#       result['root'] = true
#     else
#       parents = parent_kinds.map { |p| add_design_kind p }
#       parents.each do |p|
#         p['children'] << path
#         p['children'].uniq!
#       end
#     end
#     @kinds[path] = result
#     return result
#   end

#   def apply_for_design
#     @goods = []
#     @kinds = {}
#     add_design @page
#     @page.data['goods'] = @goods
#     @goods.each do |good|
#       kind_path = good['good']
#       kind = site.collections['goods'].docs.find { |k| k.relative_path == kind_path }
#       raise RuntimeError, "Good not found: #{ kind_path.inspect }" unless kind
#       add_design_kind kind
#     end
#     @page.data['kinds'] = @kinds
#   end

#   def add_kind kind
#     selected = @flat.select { |good| kind.relative_path == good['good'] }
#     @goods += selected
#     @goods.uniq! { |g| g['url'] }
#     if kind.data['children']
#       kind.data['children'].each do |child|
#         child_kind = site.collections['goods'].docs.find { |k| k.relative_path == child }
#         add_kind child_kind if child_kind
#       end
#     end
#     if kind.data['links']
#       kind.data['links'].each do |link|
#         link_kind = site.collections['goods'].docs.find { |k| k.relative_path == link }
#         add_kind link_kind if link_kind
#       end
#     end
#   end

#   def apply_for_kind
#     @goods = []
#     add_kind @page
#     @page.data['goods'] = @goods
#     #
#   end

# end

# Jekyll::Hooks.register :documents, :pre_render do |page, payload|

  # site = page.site
  # collection = page.collection&.label

  # if collection == 'designs'
  #   maker = DataMaker::new page
  #   maker.apply_for_design
  # elsif collection == 'goods'
  #   maker = DataMaker::new page
  #   maker.apply_for_kind
  # end

# end
