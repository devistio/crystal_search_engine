require "../spec_helper"

include SearchEngine::Crawler::Index

describe Trie do
  it "empty" do
    trie = Trie.new

    trie.get_count("").should eq(0)
    trie.get_count("", "alpha").should eq(0)
    trie.get_count("h").should eq(0)
    trie.get_count("h", "alpha").should eq(0)
    trie.get_count("you").should eq(0)
    trie.get_count("you", "alpha").should eq(0)
  end

  it "single word" do
    trie = Trie.new
    trie.insert("hey", "alpha")

    trie.get_count("").should eq(0)
    trie.get_count("", "alpha").should eq(0)
    trie.get_count("h").should eq(0)
    trie.get_count("h", "alpha").should eq(0)
    trie.get_count("you").should eq(0)
    trie.get_count("you", "alpha").should eq(0)

    trie.get_count("hey").should eq(1)
    trie.get_count("hey", "alpha").should eq(1)
  end

  it "same word multiple times" do
    trie = Trie.new
    trie.insert("hey", "alpha")
    trie.insert("hey", "alpha")
    trie.insert("hey", "beta")

    trie.get_count("").should eq(0)
    trie.get_count("", "alpha").should eq(0)
    trie.get_count("", "beta").should eq(0)
    trie.get_count("h").should eq(0)
    trie.get_count("h", "alpha").should eq(0)
    trie.get_count("h", "beta").should eq(0)
    trie.get_count("you").should eq(0)
    trie.get_count("you", "alpha").should eq(0)
    trie.get_count("you", "beta").should eq(0)

    trie.get_count("hey").should eq(3)
    trie.get_count("hey", "alpha").should eq(2)
    trie.get_count("hey", "beta").should eq(1)
  end

  it "many words" do
    trie = Trie.new
    trie.insert("hey", "alpha")
    trie.insert("hey", "alpha")
    trie.insert("hey", "beta")
    trie.insert("heaven", "alpha")
    trie.insert("ball", "beta")

    trie.get_count("").should eq(0)
    trie.get_count("", "alpha").should eq(0)
    trie.get_count("", "beta").should eq(0)
    trie.get_count("h").should eq(0)
    trie.get_count("h", "alpha").should eq(0)
    trie.get_count("h", "beta").should eq(0)
    trie.get_count("you").should eq(0)
    trie.get_count("you", "alpha").should eq(0)
    trie.get_count("you", "beta").should eq(0)

    trie.get_count("hey").should eq(3)
    trie.get_count("hey", "alpha").should eq(2)
    trie.get_count("hey", "beta").should eq(1)

    trie.get_count("heaven").should eq(1)
    trie.get_count("heaven", "alpha").should eq(1)
    trie.get_count("heaven", "beta").should eq(0)

    trie.get_count("ball").should eq(1)
    trie.get_count("ball", "alpha").should eq(0)
    trie.get_count("ball", "beta").should eq(1)
  end
end
