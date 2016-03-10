require "rails_helper"

RSpec.describe Slackmos::Commands::GoogleImages, type: :model do
  let(:fixture_path) do
    File.join(Rails.root, "spec", "support", "fixtures", "commands")
  end
  let(:cse_id)  { ENV["GOOGLE_CSE_ID"]  }
  let(:cse_key) { ENV["GOOGLE_CSE_KEY"] }

  it "gets a random top image from google images api" do
    command = command_for("pugs")
    handler = Slackmos::Commands::GoogleImages.new(command)

    pug_json = File.read(File.join(fixture_path, "google_images", "pugs.json"))

    query_string = "?cx=#{cse_id}&fields=items(link)&" \
      "key=#{cse_key}&q=pugs&safe=off&searchType=image"
    stub_request(:get, "#{handler.callback_url}#{query_string}")
      .to_return(status: 200, body: pug_json, headers: {})

    expect do
      handler.results.each do |result|
        Addressable::URI.parse(result)
      end
    end.to_not raise_error
  end

  it "gets a random top animated gif from google images api" do
    command = command_for("corgis")
    command.command = "/animate"

    handler = Slackmos::Commands::GoogleImages.new(command)

    corgis_json = File.read(
      File.join(fixture_path, "google_images", "corgis.json"))

    query_string = "?cx=#{cse_id}&fields=items(link)&fileType=gif&" \
      "hq=animated&key=#{cse_key}&q=corgis&safe=off&searchType=image&" \
      "tbs=itp:animated"
    stub_request(:get, "#{handler.callback_url}#{query_string}")
      .to_return(status: 200, body: corgis_json, headers: {})

    expect do
      handler.results.each do |result|
        Addressable::URI.parse(result)
      end
    end.to_not raise_error
  end
end
