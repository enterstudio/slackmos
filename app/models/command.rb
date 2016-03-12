# A command a Slack User issued
class Command < ApplicationRecord
  include CommandDispatcher

  belongs_to :user
  before_validation :extract_cli_args, on: :create

  def team
    @team ||= begin
                Team.find_or_create_by(team_id: team_id) do |team|
                  team.team_domain = team_domain
                end
              end
  end

  def default_response
    { response_type: "in_channel" }
  end

  def multiline_text_response(lines)
    {
      response_type: "in_channel",
      attachments: [{ text: lines.join("\n") }]
    }
  end

  def text_response(message)
    {
      text: message,
      response_type: "in_channel"
    }
  end

  def image_response(uris)
    {
      response_type: "in_channel",
      attachments: uris.map do |uri|
        {
          text: " ",
          fallback: "This is a really sweet image you're missing out on.",
          image_url: uri
        }
      end
    }
  end

  private

  def postback_message(message)
    response = client.post do |request|
      request.url callback_uri.path
      request.body = message.to_json
      request.headers["Content-Type"] = "application/json"
    end
    Rails.logger.info response.body unless response.body == "ok"
  rescue StandardError => e
    Rails.logger.info "Unable to post back to slack: '#{e.inspect}'"
  end

  def callback_uri
    @callback_uri ||= Addressable::URI.parse(response_url)
  end

  def client
    @client ||= begin
                  Faraday.new(url: "https://hooks.slack.com") do |faraday|
                    faraday.adapter Faraday.default_adapter
                  end
                end
  end

  def extract_cli_args
    self.subtask = "default"

    match = command_text.match(/-a ([-_\.0-9a-z]+)/)
    self.application = match[1] if match

    match = command_text.match(/^([-_\.0-9a-z]+)(?:\:([^\s]+))/)
    if match
      self.task    = match[1]
      self.subtask = match[2]
    end

    match = command_text.match(/^([-_\.0-9a-z]+)\s*/)
    self.task = match[1] if match
  end
end
