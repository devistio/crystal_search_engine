require "../spec_helper"

include SearchEngine::Crawler::Index

describe Trie do
  it "empty" do
    trie = Trie.new

    trie.get_count("").should eq(0)
    trie.get_count("h").should eq(0)
  end

  it "single word" do
    trie = Trie.new
    trie.insert("hey")

    trie.get_count("").should eq(0)
    trie.get_count("h").should eq(0)
    trie.get_count("hey").should eq(1)
  end

  it "same word twice" do
    trie = Trie.new
    trie.insert("hey")
    trie.insert("hey")

    trie.get_count("").should eq(0)
    trie.get_count("h").should eq(0)
    trie.get_count("hey").should eq(2)
  end

  it "many words" do
    trie = Trie.new
    trie.insert("hey")
    trie.insert("hey")
    trie.insert("hay")
    trie.insert("heaven")
    trie.insert("ball")

    trie.get_count("").should eq(0)
    trie.get_count("h").should eq(0)
    trie.get_count("hey").should eq(2)
    trie.get_count("hay").should eq(1)
    trie.get_count("heaven").should eq(1)
    trie.get_count("ball").should eq(1)
    trie.get_count("balk").should eq(0)
  end
end
