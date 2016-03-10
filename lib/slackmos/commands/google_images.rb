module Slackmos
  module Commands
    # Random Images from Google
    class GoogleImages
      attr_reader :command

      def self.google_cse_id
        ENV["GOOGLE_CSE_ID"]
      end

      def self.google_cse_key
        ENV["GOOGLE_CSE_KEY"]
      end

      def self.google_safe_search
        ENV["GOOGLE_SAFE_SEARCH"] || "high"
      end

      def initialize(command)
        @command = command
      end

      def image
        Slackmos::Commands.camo_uri(images.sample)
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
        (1..count).map { image }
      end

      def images
        response = client.get do |request|
          request.url callback_uri.path
          request.params = query_params
          request.headers["Content-Type"] = "application/json"
        end

        items = JSON.parse(response.body)["items"]
        items.map { |item| item["link"] }
      rescue StandardError => e
        Rails.logger.info "Unable to post back to slack: '#{e.inspect}'"
      end

      def query_params
        q = {
          q: command.command_text,
          searchType: "image",
          safe: self.class.google_safe_search,
          fields: "items(link)",
          cx: self.class.google_cse_id,
          key: self.class.google_cse_key
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
