module Slackmos
  module Commands
    # Eventbrite gigs for great motivation
    class Eventbrite
      attr_reader :command, :event, :team

      def initialize(command)
        @team    = Team.find_by(team_id: command.team_id)
        @command = command
      end

      def token
        team && team.value("EVENTBRITE_TOKEN")
      end

      def event
        @event ||= fetch_latest_event
      end

      def response_message
        {
          response_type: "in_channel",
          attachments: [
            {
              text: " ",
              color: "#ffffff",
              title: event["name"]["text"],
              title_link: "https://eventbrite.com/event/#{event['id']}",
              falbackk: "Unable to load that image, sorry.",
              image_url: Slackmos::Commands.camo_uri(event["logo"]["url"])
            }
          ]
        }
      end

      def fetch_latest_event
        response = client.get do |request|
          request.url callback_uri.path
          request.headers["Content-Type"] = "application/json"
          request.headers["Authorization"] = "Bearer #{token}"
        end

        data = JSON.parse(response.body)
        data && data["events"].last
      rescue StandardError => e
        Rails.logger.info e.backtrace.join("\n")
        Rails.logger.info "Unable to post back to slack: '#{e.inspect}'"
      end

      def callback_url
        "https://www.eventbriteapi.com/v3/users/me/events/"
      end

      def callback_uri
        @callback_uri ||= Addressable::URI.parse(callback_url)
      end

      def client
        @client ||= Faraday.new(url: "https://www.eventbriteapi.com")
      end
    end
  end
end

