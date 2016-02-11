require "xml"

module SearchEngine
  module Crawl
    module Extract
      # Extracs links and text from an HTML page.
      struct Extractor
        property links
        property texts
        property raw_html
        property xml

        # Initializes a new Extractor given the HTML to extract from as a string.
        def initialize(@raw_html)
          @xml = nil
        end

        # Extracts the links from the HTML.
        #
        # Returns an array containing the URL of the `href` attribute as a string
        # of each `<a>` tag as a String.
        def extract_links: Array(String)
          @xml ||= XML.parse_html(@raw_html)

          if xml = @xml
            xml.xpath_nodes(%(//a[@href!=""])).map(&.["href"]).compact
          else
            %w()
          end
        end

        # Extracts the contents of all the text nodes from the HTML.
        #
        # Returns an array containing each text node's content as a string.
        def extract_texts
          @xml ||= XML.parse_html(@raw_html)

          if xml = @xml
            xml.xpath_nodes("//text()[normalize-space()]").map(&.text).compact
          else
            %w()
          end
        end
      end
    end
  end
end
