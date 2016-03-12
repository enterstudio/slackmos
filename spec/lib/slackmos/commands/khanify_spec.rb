require "rails_helper"

RSpec.describe Slackmos::Commands::Khanify, type: :model do
  it "gets a khanified URL" do
    command = command_for("atmos")
    handler = Slackmos::Commands::Khanify.new(command)

    url = "https://github-images.s3.amazonaws.com/funsies/khan/atmos.jpg"
    stub_request(:post, handler.callback_url)
      .to_return(status: 200, body: url, headers: {})

    results = handler.results
    expect(results.size).to eql(1)
    expect do
      Addressable::URI.parse(results.first)
    end.to_not raise_error
  end
end
