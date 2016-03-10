Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV["SLACK_OAUTH_ID"], ENV["SLACK_OAUTH_SECRET"], scope: "identify,commands"
end
