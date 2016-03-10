require "rails_helper"

RSpec.describe Slackmos::Commands::Favstar, type: :model do
  let(:fixture_path) do
    File.join(Rails.root, "spec", "support", "fixtures", "commands", "favstar")
  end

  it "gets a top tweet for a user" do
    command = command_for("dril")
    handler = Slackmos::Commands::Favstar.new(command)

    dril = File.read(File.join(fixture_path, "dril.html"))

    stub_request(:get, "https://favstar.fm/users/dril")
      .to_return(status: 200, body: dril, headers: {})

    expect do
      handler.tweets.each do |result|
        Addressable::URI.parse(result)
      end
    end.to_not raise_error
  end

  it "handles users 404s on favstar" do
    username = SecureRandom.hex(24)
    command = command_for(username)
    handler = Slackmos::Commands::Favstar.new(command)

    four_of_four = File.read(File.join(fixture_path, "404.html"))

    stub_request(:get, "https://favstar.fm/users/#{username}")
      .to_return(status: 404, body: four_of_four, headers: {})

    expect do
      expect(handler.tweets).to be_empty
    end.to_not raise_error
  end
end
