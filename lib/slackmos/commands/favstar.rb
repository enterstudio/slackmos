module Slackmos
  module Commands
    # Pugs for great motivation
    class Favstar
      attr_reader :command

      def initialize(command)
        @command = command
      end

      def tweet
        tweets.sample
      end

      def tweets
        @tweets ||= find_tweets
      end

      def find_tweets
        doc = fetch_tweets
        doc.css("div.fs-tweet").map do |tweet|
          tweet_url_for_id(JSON.parse(tweet["data-model"])["tweet_id"])
        end
      end

      def fetch_tweets
        response = client.get do |request|
          request.url callback_uri.path
          request.headers["Content-Type"] = "application/json"
        end
        Nokogiri::HTML(response.body)
      rescue StandardError => e
        Rails.logger.info "Unable to post back to slack: '#{e.inspect}'"
      end

      def tweet_url_for_id(id)
        "https://twitter.com/#{command.command_text}/status/#{id}"
      end

      def callback_url
        "https://favstar.fm/users/#{command.command_text}"
      end

      def callback_uri
        @callback_uri ||= Addressable::URI.parse(callback_url)
      end

      def client
        @client ||= Faraday.new(url: "https://favstar.fm")
      end
    end
  end
end
