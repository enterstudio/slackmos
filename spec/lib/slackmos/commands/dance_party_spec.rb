require "rails_helper"

RSpec.describe Slackmos::Commands::DanceParty, type: :model do
  it "gets a dance party image" do
    command = command_for("")
    handler = Slackmos::Commands::DanceParty.new(command)

    handler.results.each do |uri|
      expect do
        Addressable::URI.parse(uri)
      end.to_not raise_error
    end
  end

  it "gets n dance party images" do
    command = command_for("x4")
    handler = Slackmos::Commands::DanceParty.new(command)

    expect(handler.results.size).to eql(4)
    handler.results.each do |uri|
      expect do
        Addressable::URI.parse(uri)
      end.to_not raise_error
    end
  end
end
