require "rails_helper"

RSpec.describe "Slackmos /jesus", type: :request do
  before do
    OmniAuth.config.mock_auth[:slack] = slack_omniauth_hash_for_atmos
    get "/auth/slack"
    follow_redirect!
  end

  def default_params(options = {})
    command_params_for("").merge(
      token: "secret-slack-token",
      user_id: "U123YG08X",
      user_name: "atmos"
    ).merge(options)
  end

  it "returns a random jesus image" do
    post_params = default_params(command: "/jesus", text: "")
    stub_request(:post, post_params[:response_url])
      .to_return(status: 200, body: "", headers: {})

    post "/commands", params: post_params

    expect(status).to eql(200)
    response_body = JSON.parse(body)
    expect(response_body["text"]).to eql(nil)
    expect(response_body["response_type"]).to eql("in_channel")
  end
end
