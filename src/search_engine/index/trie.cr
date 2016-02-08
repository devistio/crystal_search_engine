module SearchEngine
  module Index
    class Trie
      def initialize
        @out   = {} of Char => Trie
        @count = 0
      end

      def insert(word)
        return @count += 1 if word.empty?

        letter    = word.char_at(0)
        next_node = @out[letter] = Trie.new unless next_node = @out[letter]?

        next_node.insert(word[1..-1])
      end

      def get_count(word)
        return @count if word.empty?

        letter = word.char_at(0)

        if next_node = @out[letter]?
          next_node.get_count(word[1..-1])
        else
          0
        end
      end
    end
  end
end
