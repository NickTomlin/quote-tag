module Octopress
  module Tags
    module Quote
      module Utils
        def self.parse_content(content, context)
          path  = context.environments.first['page']['path']
          ext   = File.extname(path[1..-1])[1..-1]
          site  = context.registers[:site]

          if site.config['markdown_ext'].include?(ext)
            markdown_converter = site.find_converter_instance(Jekyll::Converters::Markdown)
            markdown_converter.convert(content)
          elsif defined?(Jekyll::TextileConverter) && site.config['textile_ext'].include?(ext) &&
            textile_converter = site.find_converter_instance(Jekyll::TextileConverter)
            textile_converter.convert(content)
          else
            "<p>" + content.strip.gsub(/\n\n/, "<p>\n\n</p>") + "</p>"
          end
        end
      end
    end
  end
end
