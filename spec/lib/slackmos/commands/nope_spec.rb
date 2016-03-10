require "rails_helper"

RSpec.describe Slackmos::Commands::Nope, type: :model do
  it "gets a nope image" do
    command = command_for("")
    handler = Slackmos::Commands::Nope.new(command)

    expect do
      Addressable::URI.parse(handler.image)
    end.to_not raise_error
  end

  it "gets n nope images" do
    command = command_for("x7")
    handler = Slackmos::Commands::Nope.new(command)

    expect(handler.results.size).to eql(7)
    handler.results.each do |uri|
      expect do
        Addressable::URI.parse(uri)
      end.to_not raise_error
    end
  end
end
