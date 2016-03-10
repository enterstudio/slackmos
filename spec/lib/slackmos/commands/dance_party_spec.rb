require "rails_helper"

RSpec.describe Slackmos::Commands::DanceParty, type: :model do
  it "gets a jesus image" do
    command = Slackmos::Commands::DanceParty.new

    expect do
      Addressable::URI.parse(command.image)
    end.to_not raise_error
  end
end
