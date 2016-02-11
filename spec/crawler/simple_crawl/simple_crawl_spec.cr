require "../../spec_helper"

include SearchEngine::Crawl

describe Crawler do
  it "simple crawl" do
    Dir.cd("./files/simple")
    crawler     = Crawler.new(5)
    index       = crawler.crawl("index")
    word_counts = index.get_words_and_counts

    words = %w(rat chased killed ate malt cat dog whatevs)
    words.sort.should eq(word_counts.keys.sort)

    word_counts.each do |word, count|
      case word
      when "cat", "dog", "whatevs"
        count.should eq(2)
      else
        count.should eq(1)
      end
    end
  end
end
