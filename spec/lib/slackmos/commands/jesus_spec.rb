require "rails_helper"

RSpec.describe Slackmos::Commands::Jesus, type: :model do
  it "gets a jesus image" do
    command = Slackmos::Commands::Jesus.new
    uri = Addressable::URI.parse(command.image)

    expect(uri.scheme).to eql("http")
    expect(uri.path).to match(%r{dump/jesus/.*\.jpg}i)
    expect(uri.hostname).to eql("cdn.lstoll.net")
  end
end
