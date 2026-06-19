module Jekyll
  class ConsoleLogTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
    end

    def render(context)
      # Resolve variable if a variable name was passed instead of a raw string
      resolved_value = context[@text] || @text

      # Print to the terminal console
      puts "\e[33m[Liquid Log]\e[0m #{resolved_value}"

      # Return nothing to the HTML output
      ""
    end
  end
end

Liquid::Template.register_tag('console_log', Jekyll::ConsoleLogTag)
