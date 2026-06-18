module Jekyll

  class GoodsGenerator < Generator

    safe true
    priority :high

    SOURCE = 'goods'

    def generate site
      flattened = []
      source = site.data[SOURCE]
      process_data_node source, flattened if source
      site.data['flat_goods'] = flattened
    end

    private

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
