ENV["SLACK_APP_URL"] = "https://slack.com/apps/manage/A0QS72-slash-hubot-deploy"

ENV["SLACK_SLASH_COMMAND_TOKEN"] = "secret-slack-token"

require "webmock/rspec"
require "sidekiq/testing"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include(WebMock::API)
  config.before do
    WebMock.reset!
    WebMock.disable_net_connect!
  end

  # rubocop:disable Metrics/LineLength
  def slack_omniauth_hash_for_atmos
    info = {
      description: nil,
      email: "atmos@atmos.org",
      first_name: "Corey",
      last_name: "Donohoe",
      image: "https://secure.gravatar.com/avatar/a86224d72ce21cd9f5bee6784d4b06c7.jpg?s=192&d=https%3A%2F%2Fslack.global.ssl.fastly.net%2F7fa9%2Fimg%2Favatars%2Fava_0010-192.png",
      image_48: "https://secure.gravatar.com/avatar/a86224d72ce21cd9f5bee6784d4b06c7.jpg?s=48&d=https%3A%2F%2Fslack.global.ssl.fastly.net%2F66f9%2Fimg%2Favatars%2Fava_0010-48.png",
      is_admin: true,
      is_owner: true,
      name: "Corey Donohoe",
      nickname: "atmos",
      team: "Zero Fucks LTD",
      team_id: "T123YG08V",
      time_zone: "America/Los_Angeles",
      user: "atmos",
      user_id: "U123YG08X"
    }
    credentials = {
      token: SecureRandom.hex(24)
    }

    OmniAuth::AuthHash.new(provider: "slack",
                           uid: "U024YG08X",
                           info: info,
                           credentials: credentials)
  end

  def google_omniauth_hash_for_atmos
    info = {
      name: "Corey Donohoe",
      first_name: "Donohoe",
      last_name: "Corey",
      email: "atmos@atmos.org",
      image: "https://lh3.googleusercontent.com/-3XZvZiEfr_c/AAAAAAAAAAI/AAAAAAAAACo/luBamazvxvM/photo.jpg"
    }
    credentials = {
      token: SecureRandom.hex(24),
      expires: true,
      expires_at: 6.hours.from_now
    }

    OmniAuth::AuthHash.new(provider: "google_oauth2",
                           uid: "9018796622324100135828",
                           info: info,
                           credentials: credentials)
  end

  def create_atmos
    slack = slack_omniauth_hash_for_atmos
    options = {
      slack_user_id: slack.info.user_id,
      slack_user_name: slack.info.name,
      slack_team_id: slack.info.team_id
    }
    User.create(options)
  end

  def command_params_for(text)
    {
      channel_id: "C99NNAY74",
      channel_name: "zf-promo",
      command: "/deploy",
      response_url: "https://hooks.slack.com/commands/T123YG08V/2459573/mfZPdDq",
      team_id: "T123YG08V",
      team_domain: "zf",
      text: text
    }
  end

  def command_for(text)
    user = create_atmos
    user.create_command_for(command_params_for(text))
  end
end
