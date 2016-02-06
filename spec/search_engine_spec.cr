require "./spec_helper"

describe SearchEngine do
  it "normalize simple" do
    norm   = Normalization::Normalizer.new([] of String, "", true)
    text   = "The rat the cat the dog chased killed ate the malt, dude."
    output = %w(The rat the cat the dog chased killed ate the malt, dude.)

    norm.normalize(text).should eq(output)
  end

  it "normalize punctation" do
    norm   = Normalization::Normalizer.new([] of String, ".,", true)
    text   = "The rat the cat the dog chased killed ate the malt, dude."
    output = %w(The rat the cat the dog chased killed ate the malt dude)

    norm.normalize(text).should eq(output)
  end
end
