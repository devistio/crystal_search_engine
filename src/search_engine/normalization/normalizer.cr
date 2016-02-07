require "./defaults"

module SearchEngine
  module Normalization
    # Used to normalize text before indexing. Default (English) stopwords and
    # punctuation are provided, although functionality exists for custom
    # parameters.
    class Normalizer
      def initialize(@stopwords = Defaults::STOPWORDS, @punctuation = Defaults::PUNCTUATION,
        @ignore_single_quotes = true)
      end

      # Normalizes text by eliminating whitespace, stopwords, and punctuation.
      def normalize(text)
        words = text.downcase.split(get_splitter_regex(punctuation))

        words.reduce([] of String) do |normalized_words, word|
          word = strip_single_quotes(word) if @ignore_single_quotes

          normalized_words << word unless @stopwords.includes?(word) || word.empty?
          normalized_words
        end
      end

      private def get_splitter_regex(string)
        char_strings = string.split("").reject(&.empty?)
        char_regexes = char_strings.map { |c| Regex.new(Regex.escape(c)) }

        Regex.union([/\s+/] + char_regexes)
      end

      private def strip_single_quotes(word)
        word.chomp('\'').sub(/^'+/, "")
      end
    end
  end
end
