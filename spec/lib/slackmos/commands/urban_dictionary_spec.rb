require "rails_helper"

RSpec.describe Slackmos::Commands::UrbanDictionary, type: :model do
  let(:fixture_path) do
    File.join(Rails.root, "spec", "support", "fixtures", "commands")
  end

  it "gets a top tweet for a user" do
    command = command_for("stolting")
    handler = Slackmos::Commands::UrbanDictionary.new(command)

    stolting = File.read(
      File.join(fixture_path, "urban_dictionary", "stolting.json"))

    stub_request(:get, "#{handler.callback_url}?term=stolting")
      .to_return(status: 200, body: stolting, headers: {})

    definition = handler.definition
    expect(definition["definition"]).to_not be_nil
    expect(definition["permalink"])
      .to eql("http://stolting.urbanup.com/5448762")
  end

  it "handles users 404s on urban dictionary" do
    username = SecureRandom.hex(24)
    command = command_for(username)
    handler = Slackmos::Commands::UrbanDictionary.new(command)

    four_oh_four = File.read(
      File.join(fixture_path, "urban_dictionary", "404.json"))

    stub_request(:get, "#{handler.callback_url}?term=#{username}")
      .to_return(status: 200, body: four_oh_four, headers: {})

    definition = handler.definition
    expect(definition).to eql(nil)
  end
end
