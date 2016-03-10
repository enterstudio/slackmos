require "rails_helper"

RSpec.describe Slackmos::Commands::Pugs, type: :model do
  let(:fixture_path) do
    File.join(Rails.root, "spec", "support", "fixtures", "commands", "pugs")
  end

  it "gets a random pug from the index" do
    command = command_for("bomb")
    handler = Slackmos::Commands::Pugs.new(command)

    pug = File.read(File.join(fixture_path, "pug.json"))

    stub_request(:get, "#{handler.callback_url}?count=1")
      .to_return(status: 200, body: pug, headers: {})

    expect do
      handler.results.each do |result|
        Addressable::URI.parse(result)
      end
    end.to_not raise_error
  end

  it "gets a pug bomb from the index" do
    command = command_for("bomb x5")
    command.command = "/pug"

    handler = Slackmos::Commands::Pugs.new(command)

    pugs_x5 = File.read(File.join(fixture_path, "pugs_x5.json"))

    stub_request(:get, "#{handler.callback_url}?count=5")
      .to_return(status: 200, body: pugs_x5, headers: {})

    expect do
      handler.results.each do |result|
        Addressable::URI.parse(result)
      end
    end.to_not raise_error
  end
end
