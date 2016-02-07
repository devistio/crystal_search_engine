require "xml"

module SearchEngine
  module Extraction
    class Extractor
      def initialize(@raw_html)
        @links = nil
        @texts = nil
        @xml   = nil
      end

      def extract_links
        return @links if @links

        @xml ||= XML.parse_html(@raw_html)

        if xml = @xml
          links = xml.xpath_nodes("//a").map(&.["href"]?)
          return @links = links.compact.reject(&.empty?)
        end

        @links = %w()
      end

      def extract_texts
        return @texts if @texts

        @xml ||= XML.parse_html(@raw_html)

        if xml = @xml
          texts = xml.xpath_nodes("//text()").map(&.text)
          return @texts = texts.compact.map(&.strip).reject(&.empty?)
        end

        @texts = %w()
      end
    end
  end
end
