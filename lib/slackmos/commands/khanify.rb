module Slackmos
  module Commands
    # Express frustration with Khaaaaaan
    class Khanify
      attr_reader :command

      def initialize(command)
        @command = command
      end

      def results
        [fetch_url]
      end

      def fetch_url
        response = client.post do |request|
          request.url callback_uri.path
          request.body = JSON.dump(text: command.command_text)
          request.headers["Content-Type"] = "application/json"
        end
        response.body
      rescue StandardError => e
        Rails.logger.info "Unable to khanify that. #{e.inspect}"
      end

      def callback_url
        "https://github-khanify.herokuapp.com/khanify"
      end

      def callback_uri
        @callback_uri ||= Addressable::URI.parse(callback_url)
      end

      def client
        @client ||= Faraday.new(url: callback_url)
      end
    end
  end
end
