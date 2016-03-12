application_url = ENV["SLACK_APP_URL"] || "https://github.com/atmos/slackmos"
Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  # mount ActionCable.server => "/cable"
  get  "/boomtown"                    => "application#boomtown"
  post "/commands"                    => "commands#create"

  get  "/auth/failure"                => "sessions#destroy"
  get  "/auth/complete"               => "sessions#complete"
  get  "/auth/slack/callback"         => "sessions#create_slack"
  get  "/auth/google_oauth2/callback" => "sessions#create_google"

  root to: redirect(application_url, status: 302)
end
