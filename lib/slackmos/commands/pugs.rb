module Slackmos
  module Commands
    # Pugs for great motivation
    class Pugs
      attr_reader :command

      def initialize(command)
        @command = command
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
        (1..count).map { image }
      end

      def images
        response = client.get do |request|
          request.url callback_uri.path
          request.params = { count: count }
          request.headers["Content-Type"] = "application/json"
        end

        JSON.parse(response.body)["pugs"]
      rescue StandardError => e
        Rails.logger.info "Unable to post back to slack: '#{e.inspect}'"
      end

      def callback_url
        "https://pugme.herokuapp.com/bomb"
      end

      def callback_uri
        @callback_uri ||= Addressable::URI.parse(callback_url)
      end

      def client
        @client ||= Faraday.new(url: "https://pugme.herokuapp.com")
      end
    end
  end
end
