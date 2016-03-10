require "rails_helper"

RSpec.describe Slackmos::Commands::DanceParty, type: :model do
  it "gets a jesus image" do
    command = command_for("")
    handler = Slackmos::Commands::DanceParty.new(command)

    expect do
      Addressable::URI.parse(handler.image)
    end.to_not raise_error
  end
end
