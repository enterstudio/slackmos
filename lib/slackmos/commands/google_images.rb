module Slackmos
  module Commands
    # Random Images from Google
    class GoogleImages
      attr_reader :command, :team

      def initialize(command)
        @team    = command.team
        @command = command
      end

      def google_safe_search
        (team && team.google_cse_safe_search) || "medium"
      end

      def google_cse_id
        team && team.google_cse_id
      end

      def google_cse_key
        team && team.google_cse_key
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
        (1..count).map { images.sample }.compact
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
        Rails.logger.info response.body
        JSON.parse(response.body)
      rescue StandardError => e
        Rails.logger.info "Unable to post back to slack: '#{e.inspect}'"
        nil
      end

      # https://developers.google.com/custom-search/json-api/v1/reference/cse/list#parameters
      def query_params
        q = {
          q: command.command_text,
          cx: google_cse_id,
          num: 10,
          key: google_cse_key,
          safe: google_safe_search,
          fields: "items(link)",
          searchType: "image",
          imgSize: "large"
        }
        if command.command == "/animate"
          q[:hq] = "animated"
          q[:tbs] = "itp:animated"
          q[:fileType] = "gif"
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
