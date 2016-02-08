require "./crawl/index/trie"
require "./crawl/normalize/normalizer"

require "http/client"

module SearchEngine
  module Crawl
    class Crawler
      def initialize(@max_pages)
        @index  = Trie.new
        @norm   = Normalizer.new
        @queue  = %w()
        @seen   = Set.new
      end

      def crawl(@seed)
        clear_all
        @queue.push(@seed)
        pages = @max_pages

        unless @queue.empty? || pages == 0
          url = @queue.shift
          @seen.add(url)

          response = HTTP::Client.get(url)
          next unless response.status_code == 200

          extract = Extractor.new(response.body)
          links   = extract.extract_links
          @queue.push(*links.reject { |l| @seen.includes?(l) })

          texts = extract.extract_texts
          texts.each do |text|
            @norm.normalize(text).each { |word| @index.insert(word, url) }
          end
        end

        @index
      end


      private def clear_all
        @index.clear
        @queue.clear
        @seen.clear
      end
    end
  end
end
