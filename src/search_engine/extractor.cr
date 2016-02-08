require "xml"

module SearchEngine
  module Extraction
    struct Extractor
      property links
      property texts
      property raw_html
      property xml

      def initialize(@raw_html)
        @links = nil
        @texts = nil
        @xml   = nil
      end

      def extract_links
        return @links if @links

        @xml ||= XML.parse_html(@raw_html)

        @links = if xml = @xml
          xml.xpath_nodes(%(//a[@href!=""])).map(&.["href"])
        else
          %w()
        end
      end

      def extract_texts
        return @texts if @texts

        @xml ||= XML.parse_html(@raw_html)

        @texts = if xml = @xml
          xml.xpath_nodes("//text()[normalize-space()]").map(&.text).compact
        else
          %w()
        end
      end
    end
  end
end
