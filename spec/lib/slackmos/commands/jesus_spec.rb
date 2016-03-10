require "rails_helper"

RSpec.describe Slackmos::Commands::Jesus, type: :model do
  it "gets a jesus image" do
    command = command_for("")
    handler = Slackmos::Commands::Jesus.new(command)
    uri = Addressable::URI.parse(handler.image)

    expect(uri.scheme).to eql("http")
    expect(uri.path).to match(%r{dump/jesus/.*\.jpg}i)
    expect(uri.hostname).to eql("cdn.lstoll.net")
  end

  it "gets n jesus images" do
    command = command_for("x7")
    handler = Slackmos::Commands::Jesus.new(command)

    expect(handler.results.size).to eql(7)
    handler.results.each do |uri|
      expect do
        Addressable::URI.parse(uri)
      end.to_not raise_error
    end
  end
end
