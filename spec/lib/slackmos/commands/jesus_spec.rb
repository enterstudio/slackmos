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
end
