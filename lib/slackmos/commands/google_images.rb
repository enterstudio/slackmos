module Slackmos
  module Commands
    # Random Images from Google
    class GoogleImages
      attr_reader :command, :team

      def initialize(command)
        @team    = Team.find_by(team_id: command.team_id)
        @command = command
      end

      def google_safe_search
        if team && team.value("GOOGLE_SAFE_SEARCH")
          team.value("GOOGLE_SAFE_SEARCH")
        else
          "high"
        end
      end

      def google_cse_id
        team && team.value("GOOGLE_CSE_ID")
      end

      def google_cse_key
        team && team.value("GOOGLE_CSE_KEY")
      end

      def image
        images.sample
      end

      def count
        result = 1
        matches = command.command_text.match(/x(\d+)/)
        if matches
          result = Integer(matches[1])
        end
        result = 1 if result > 5
        result
      end

      def results
        (1..count).map { image }.compact
      end

      def images
        @images ||= find_images
      end

      def find_images
        items = fetch_images
        if items && items["items"]
          items["items"].map { |item| item["link"] }
        else
          []
        end
      end

      def fetch_images
        response = client.get do |request|
          request.url callback_uri.path
          request.params = query_params
          request.headers["Content-Type"] = "application/json"
        end
        JSON.parse(response.body)
      rescue StandardError => e
        Rails.logger.info "Unable to post back to slack: '#{e.inspect}'"
      end

      def query_params
        q = {
          q: command.command_text,
          searchType: "image",
          safe: google_safe_search,
          fields: "items(link)",
          cx: google_cse_id,
          key: google_cse_key
        }
        if command.command == "/animate"
          q[:fileType] = "gif"
          q[:hq] = "animated"
          q[:tbs] = "itp:animated"
        end
        q
      end

      def callback_url
        "https://www.googleapis.com/customsearch/v1"
      end

      def callback_uri
        @callback_uri ||= Addressable::URI.parse(callback_url)
      end

      def client
        @client ||= Faraday.new(url: "https://www.googleapis.com")
      end
    end
  end
end
