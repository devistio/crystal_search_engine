module SearchEngine
  module Crawl
    module Index
      # Used to keep track of word occurences; essentially a memory-efficient
      # (String => Int32) map.
      class Trie
        def initialize
          @out    = {} of Char => Trie
          @counts = Hash(String, Int32).new(0)
        end

        # Clear out all of the stored data
        def clear
          @out.clear
          @counts.clear
        end

        # Retrieves all words stored in the trie as well as their respective
        # counts.
        #
        # Returns a hash where the keys are the strings stored in the trie
        # and the values are their counts.
        def get_words_and_counts
          word_counts = {} of String => Int32

          @out.each do |char, trie|
            trie.get_words_and_counts.each do |word, count|
              word_counts[char + word] = count
            end
          end

          count = @counts.values.sum
          word_counts[""] = count if count > 0
          word_counts
        end

        # Increments the count of a given word in a given document.
        def insert(word, document, count = 1)
          return @counts[document] += count if word.empty?

          letter    = word.char_at(0)
          next_node = @out[letter] = Trie.new unless next_node = @out[letter]?

          next_node.insert(word[1..-1], document, count)
        end

        # Returns the count of a given word.
        def get_count(word, document = nil)

          if word.empty?
            count = if document
                      @counts[document]
                    else
                      @counts.values.sum
                    end

            return count
          end

          letter = word.char_at(0)

          if next_node = @out[letter]?
            next_node.get_count(word[1..-1], document)
          else
            0
          end
        end
      end
    end
  end
end
