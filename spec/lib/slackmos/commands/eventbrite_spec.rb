require "rails_helper"

RSpec.describe Slackmos::Commands::Eventbrite, type: :model do
  let(:fixture_path) do
    File.join(
      Rails.root, "spec", "support", "fixtures", "commands", "eventbrite")
  end

  it "displays the latest eventbrite event" do
    command = command_for("bomb")

    team = Team.create(team_id: command.team_id)
    TeamSetting.create(team_id: team.id, key: "EVENTBRITE_TOKEN", value: SecureRandom.hex(12))

    handler = Slackmos::Commands::Eventbrite.new(command)

    zf_json = File.read(File.join(fixture_path, "zf.json"))

    stub_request(:get, handler.callback_url)
      .to_return(status: 200, body: zf_json, headers: {})

    expect(handler.event).to_not be_empty
  end
end
