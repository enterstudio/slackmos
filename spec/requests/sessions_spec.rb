require "rails_helper"

RSpec.describe "Authentication", type: :request do
  before do
    OmniAuth.config.mock_auth[:slack] = slack_omniauth_hash_for_atmos
  end

  def omniauth_url
    "http://www.example.com/"
  end

  def application_url
    "https://slack.com/apps/manage/A0QS72-slash-hubot-deploy"
  end

  it "requires a valid rails session" do
    get "/auth/slack"
    expect(status).to eql(302)
    expect(headers["Location"]).to eql("#{omniauth_url}auth/slack/callback")
    follow_redirect!

    # /auth/google_oauth2
    expect(status).to eql(302)
    follow_redirect!

    # /auth/google_oauth2/callback
    expect(status).to eql(302)
    expect(headers["Location"])
      .to eql("#{omniauth_url}auth/google_oauth2/callback")
    follow_redirect!

    # /auth/complete
    expect(status).to eql(302)
    follow_redirect!

    # /auth/complete - thanks and goodbye
    expect(status).to eql(200)
    expect(body).to include("See you, Space Cowboy.")
    expect(body).to include("https://slack.com/messages")
  end

  it "preserves the origin parameter when chat initiated" do
    command = command_for("cheetahs")
    command.command = "/img"

    origin = {
      uri: "slack://channel?team_id=T028&id=C028"
    }
    encoded_origin = Slackmos.encode_origin(origin)

    # Calling back from Slack's OAuth handshake
    get "/auth/slack?origin=#{encoded_origin}"
    expect(status).to eql(302)
    expect(headers["Location"])
      .to eql("#{omniauth_url}auth/slack/callback")
    follow_redirect!

    # /auth/google_oauth2
    expect(status).to eql(302)
    expect(headers["Location"])
      .to eql("#{omniauth_url}auth/google_oauth2?origin=#{encoded_origin}")
    follow_redirect!

    # /auth/google_oauth2/callback
    expect(status).to eql(302)
    expect(headers["Location"])
      .to eql("#{omniauth_url}auth/google_oauth2/callback")
    follow_redirect!

    # /auth/complete
    expect(status).to eql(302)
    follow_redirect!

    # /auth/complete - thanks and goodbye
    # Redirect to slack://channel
    expect(status).to eql(200)
    expect(body).to include("See you, Space Cowboy.")
    expect(body).to include(origin[:uri])
  end

  it "rejects uris that aren't slack url handlers" do
    origin = {
      uri: "https://imgur.com",
      token: nil
    }
    encoded_origin = Slackmos.encode_origin(origin)

    # Calling back from Slack's OAuth handshake
    get "/auth/slack?origin=#{encoded_origin}"
    expect(status).to eql(302)
    expect(headers["Location"])
      .to eql("#{omniauth_url}auth/slack/callback")
    follow_redirect!

    # /auth/google_oauth2
    expect(status).to eql(302)
    expect(headers["Location"])
      .to eql("#{omniauth_url}auth/google_oauth2?origin=#{encoded_origin}")
    follow_redirect!

    # /auth/google_oauth2/callback
    expect(status).to eql(302)
    expect(headers["Location"])
      .to eql("#{omniauth_url}auth/google_oauth2/callback")
    follow_redirect!

    # /auth/complete
    expect(status).to eql(302)
    follow_redirect!

    # /auth/complete - thanks and goodbye
    # Redirect to slack://channel
    expect(status).to eql(200)
    expect(body).to include("See you, Space Cowboy.")
    expect(body).to include("https://slack.com/messages")
  end
end
