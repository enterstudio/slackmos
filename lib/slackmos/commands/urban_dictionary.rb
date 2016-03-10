require "cgi"

module Slackmos
  module Commands
    # Help you understand slang
    class UrbanDictionary
      attr_reader :command

      def initialize(command)
        @command = command
      end

      def definition
        @definition ||= definitions.sample
      end

      def definitions
        response = client.get do |request|
          request.url callback_uri.path
          request.params = { term: CGI.escape(command.command_text) }
        end

        JSON.parse(response.body)["list"]
      rescue StandardError => e
        Rails.logger.info "Unable to post back to slack: '#{e.inspect}'"
      end

      def callback_url
        "http://api.urbandictionary.com/v0/define"
      end

      def callback_uri
        @callback_uri ||= Addressable::URI.parse(callback_url)
      end

      def client
        @client ||= Faraday.new(url: "http://api.urbandictionary.com")
      end

      def response_message
        if definition
          success_message
        else
          not_found_message
        end
      end

      def success_message
        {
          response_type: "in_channel",
          attachments: [
            {
              fallback: "Definition from Urban Dictionary",
              title: "#{definition['word']} - Urban Dictionary",
              title_link: definition["permalink"],
              text: definition["definition"],
              color: "#9EAEB3"
            }
          ]
        }
      end

      def not_found_message
        {
          text: "Unable to find a definition for #{command.command_text}",
          response_type: "in_channel"
        }
      end
    end
  end
end
