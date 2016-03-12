# Module to mix in running all the commands
module CommandDispatcher
  extend ActiveSupport::Concern

  included do
  end

  # Things exposed to the included class as class methods
  module ClassMethods
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/CyclomaticComplexity
  def run
    case command
    when "/pug"
      pugs = Slackmos::Commands::Pugs.new(self)
      postback_message(image_response(pugs.results))
    when "/jesus"
      jesus = Slackmos::Commands::Jesus.new(self)
      postback_message(image_response(jesus.results))
    when "/dance"
      dance_party = Slackmos::Commands::DanceParty.new(self)
      postback_message(image_response(dance_party.results))
    when "/nope", "/yep"
      nope = Slackmos::Commands::Nope.new(self)
      postback_message(image_response(nope.results))
    when "/define"
      definition = Slackmos::Commands::UrbanDictionary.new(self)
      postback_message(definition.response_message)
    when "/eventbrite"
      definition = Slackmos::Commands::Eventbrite.new(self)
      postback_message(definition.response_message)
    when "/classic"
      favstar = Slackmos::Commands::Favstar.new(self)
      text = favstar.tweet
      text = "No classic tweets from #{command_text}" if favstar.tweets.empty?
      postback_message(response_type: "in_channel", text: text)
    when "/img", "/animate"
      google_images = Slackmos::Commands::GoogleImages.new(self)
      results = google_images.results
      if results.any?
        postback_message(image_response(google_images.results))
      else
        msg = "Google Custom Search Engine isn't configured for this team."
        postback_message(text_response(msg))
      end
    when "/pizza"
      pizza = Slackmos::Commands::Pizza.new(self)
      postback_message(image_response(pizza.results))
    when "/complete"
      complete = Slackmos::Commands::Complete.new(self)
      postback_message(multiline_text_response(complete.results))
    when "/khanify"
      khanify = Slackmos::Commands::Khanify.new(self)
      Rails.logger.info(image_response(khanify.results))
      postback_message(image_response(khanify.results))
    else
      Rails.logger.info "Unhandled command #{id}"
    end
  end
  # rubocop:enable Metrics/AbcSize
end
