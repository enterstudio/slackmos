require "rails_helper"

RSpec.describe Slackmos::Commands::Complete, type: :model do
  let(:fixture_path) do
    File.join(Rails.root, "spec", "support", "fixtures", "commands", "complete")
  end

  before do
    #WebMock.allow_net_connect!
  end
  it "gets 5 results from google suggest" do
    command = command_for("why do dogs")
    handler = Slackmos::Commands::Complete.new(command)

    dogs = File.read(File.join(fixture_path, "why_do_dogs.xml"))

    query_string = "#{handler.callback_url}?output=toolbar&q=why%20do%20dogs"
    stub_request(:get, query_string)
      .to_return(status: 200, body: dogs, headers: {})

    results = handler.results

    expect(results.size).to eql(5)
    results.each do |result|
      expect(result).to match(/why do dogs/)
    end
  end

  it "gets a pug bomb from the index" do
    command = command_for("x10 why do cats")
    handler = Slackmos::Commands::Complete.new(command)

    cats = File.read(File.join(fixture_path, "why_do_cats.xml"))

    query_string = "#{handler.callback_url}?output=toolbar&q=why%20do%20cats"
    stub_request(:get, query_string)
      .to_return(status: 200, body: cats, headers: {})

    results = handler.results

    expect(results.size).to eql(10)
    results.each do |result|
      expect(result).to match(/why do cats/)
    end
  end
end
