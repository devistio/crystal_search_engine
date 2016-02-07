require "./spec_helper"

include SearchEngine::Normalization

describe Normalizer do
  it "#normalize simple" do
    norm   = Normalizer.new(%w(), "", false)
    text   = "The rat the cat the dog chased killed ate the malt, dude."
    output = %w(the rat the cat the dog chased killed ate the malt, dude.)

    norm.normalize(text).should eq(output)
  end

  it "#normalize with single quotes" do
    norm   = Normalizer.new(%w(), "", true)
    text   = "It's Chris' cat."
    output = %w(it's chris cat.)

    norm.normalize(text).should eq(output)
  end

  it "#normalize punctuation" do
    norm   = Normalizer.new(%w(), ".,", true)
    text   = "The rat the cat the dog chased killed ate the malt, dude."
    output = %w(the rat the cat the dog chased killed ate the malt dude)

    norm.normalize(text).should eq(output)
  end

  it "#normalize stopwords" do
    norm   = Normalizer.new(%w(the), "", false)
    text   = "The rat the cat the dog chased killed ate the malt, dude."
    output = %w(rat cat dog chased killed ate malt, dude.)

    norm.normalize(text).should eq(output)
  end

  it "#normalize punctuation stopwords" do
    norm   = Normalizer.new(%w(the), ",.", false)
    text   = "The rat the cat the dog chased killed ate the malt, dude."
    output = %w(rat cat dog chased killed ate malt dude)

    norm.normalize(text).should eq(output)
  end

  it "#normalize default args" do
    norm   = Normalizer.new
    text   = "So, it's 'about' these."
    output = %w()

    norm.normalize(text).should eq(output)
  end
end
