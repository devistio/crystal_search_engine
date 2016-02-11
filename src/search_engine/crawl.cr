require "./crawl/index/trie"
require "./crawl/normalize/normalizer"

require "http/client"

module SearchEngine
  module Crawl
    class Crawler
      def initialize(@max_pages)
        @index  = Index::Trie.new
        @norm   = Normalize::Normalizer.new
        @queue  = %w()
        @seen   = Set(String).new
      end

      def crawl(seed, local = true)
        clear_all
        @queue.push(seed)
        pages = @max_pages

        until @queue.empty? || pages == 0
          url = @queue.shift
          @seen.add(url)
          next unless html = fetch(url, local)

          extract = Extract::Extractor.new(html)
          links   = extract.extract_links
          @queue += links.reject { |l| @seen.includes?(l) }
          texts   = extract.extract_texts
          
          texts.each do |text|
            @norm.normalize(text).each { |word| @index.insert(word, url) }
          end

          pages -= 1
        end

        @index
      end

      private def fetch(url, local)
        return File.read(url) if local

        response = HTTP::Client.get(url)
        response.status_code == 200 ? response.body : nil
      end

      private def clear_all
        @index.clear
        @queue.clear
        @seen.clear
      end
    end
  end
end
