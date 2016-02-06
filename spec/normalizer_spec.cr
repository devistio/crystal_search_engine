require "./spec_helper"

include SearchEngine::Normalization

describe Normalizer do
  it "#normalize simple" do
    norm   = Normalizer.new(%w(), "", true)
    text   = "The rat the cat the dog chased killed ate the malt, dude."
    output = %w(the rat the cat the dog chased killed ate the malt, dude.)

    norm.normalize(text).should eq(output)
  end

  it "#normalize punctation" do
    norm   = Normalizer.new(%w(), ".,", true)
    text   = "The rat the cat the dog chased killed ate the malt, dude."
    output = %w(the rat the cat the dog chased killed ate the malt dude)

    norm.normalize(text).should eq(output)
  end

  it "#normalize stopwords" do
    norm   = Normalizer.new(%w(the), "", true)
    text   = "The rat the cat the dog chased killed ate the malt, dude."
    output = %w(rat cat dog chased killed ate malt, dude.)

    norm.normalize(text).should eq(output)
  end

  it "#normalize punctation stopwords" do
    norm   = Normalizer.new(%w(the), ",.", true)
    text   = "The rat the cat the dog chased killed ate the malt, dude."
    output = %w(rat cat dog chased killed ate malt dude)

    norm.normalize(text).should eq(output)
  end
end
