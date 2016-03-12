module Slackmos
  module Commands
    # Pugs for great motivation
    class Complete
      attr_reader :command, :suggestion_xpath

      def initialize(command)
        @command          = command
        @suggestion_xpath = "//CompleteSuggestion/suggestion"
      end

      def search_string
        command.command_text.gsub(/x\d+\s*/, '')
      end

      def count
        result = 5
        matches = command.command_text.match(/x(\d+)/)
        if matches
          result = Integer(matches[1])
        end
        result = 5 if result > 10
        result
      end

      def results
        suggestions[0..count-1]
      end

      def suggestions
        @suggestions ||= suggestions!
      end

      def suggestions!
        response = client.get do |request|
          request.url callback_uri.path
          request.params = { q: search_string, output: "toolbar" }
          request.headers["Content-Type"] = "application/json"
        end
        Nokogiri::XML(response.body).xpath(suggestion_xpath).map do |element|
          element["data"]
        end
      rescue StandardError => e
        Rails.logger.info "Unable to fetch suggestions from #{callback_url.host} : '#{e.inspect}'"
      end

      def callback_url
        "https://suggestqueries.google.com/complete/search"
      end

      def callback_uri
        @callback_uri ||= Addressable::URI.parse(callback_url)
      end

      def client
        @client ||= Faraday.new(url: "https://suggestqueries.google.com")
      end
    end
  end
end

