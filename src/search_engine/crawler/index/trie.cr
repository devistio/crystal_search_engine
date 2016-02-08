module SearchEngine
  module Crawler
    module Index
      # Used to keep track of word occurences; essentially a memory-efficient
      # (String => Int32) map.
      class Trie
        def initialize
          @out    = {} of Char => Trie
          @counts = Hash(String, Int32).new(0)
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
