require "rails_helper"

RSpec.describe Slackmos::Commands::GoogleImages, type: :model do
  let(:fixture_path) do
    File.join(Rails.root, "spec", "support", "fixtures", "commands")
  end

  it "gets a random top image from google images api" do
    command = command_for("pugs")

    command.team.team_settings.create(key: "GOOGLE_CSE_ID", value: "id")
    command.team.team_settings.create(key: "GOOGLE_CSE_KEY", value: "key")

    handler = Slackmos::Commands::GoogleImages.new(command)

    pug_json = File.read(File.join(fixture_path, "google_images", "pugs.json"))

    query = "?cx=id&fields=items(link)&imgSize=large&key=key" \
              "&num=10&q=pugs&safe=medium&searchType=image"
    stub_request(:get, "#{handler.callback_url}#{query}")
      .to_return(status: 200, body: pug_json, headers: {})

    handler.results.each do |result|
      expect do
        Addressable::URI.parse(result)
      end.to_not raise_error
    end
  end

  it "tells you when google images isn't configured" do
    command = command_for("pugs")

    handler = Slackmos::Commands::GoogleImages.new(command)

    unauthed = File.read(File.join(fixture_path, "google_images", "400.json"))

    query = "?cx&fields=items(link)&imgSize=large&key&num=10&" \
              "q=pugs&safe=medium&searchType=image"
    stub_request(:get, "#{handler.callback_url}#{query}")
      .to_return(status: 400, body: unauthed, headers: {})

    expect(handler.results).to be_empty
  end

  it "gets a random top animated gif from google images api" do
    command = command_for("corgis")
    command.command = "/animate"

    command.team.team_settings.create(key: "GOOGLE_CSE_ID", value: "id")
    command.team.team_settings.create(key: "GOOGLE_CSE_KEY", value: "key")

    handler = Slackmos::Commands::GoogleImages.new(command)

    corgis_json = File.read(
      File.join(fixture_path, "google_images", "corgis.json"))

    query_string = "?cx=id&fields=items(link)&fileType=gif&" \
      "hq=animated&imgSize=large&key=key&num=10&q=corgis&safe=" \
      "medium&searchType=image&tbs=itp:animated"
    stub_request(:get, "#{handler.callback_url}#{query_string}")
      .to_return(status: 200, body: corgis_json, headers: {})

    handler.results.each do |result|
      expect do
        Addressable::URI.parse(result)
      end.to_not raise_error
    end
  end
end
