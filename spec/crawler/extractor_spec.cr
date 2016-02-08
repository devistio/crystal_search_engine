require "../spec_helper"

include SearchEngine::Crawl::Extraction

describe Extractor do
  html = %(
    <html>
      <head>
        <title>Grumpy Wizards</title>
      </head>
      <body>
        <p>toxic brew</p>
        <div>
          <a href="evil_queen">evil queen</a>
        </div>
        <a href="jack">jack</a>
        <a>blank</a>
        <a href="">empty</a>
      </body>
    </html>
    )
  extractor = Extractor.new(html)

  it "#extract_links" do
    output    = %w(evil_queen jack)

    extractor.extract_links.should eq(output)
  end

  it "#extract_texts" do
    output = ["Grumpy Wizards", "toxic brew", "evil queen", "jack", "blank", "empty"]

    extractor.extract_texts.should eq(output)
  end
end
