module Slackmos
  # Module for containing all the slash commands
  module Commands
    def self.camo_uri(uri)
      if ENV["CAMO_HOST"] && ENV["CAMO_KEY"] && ENV["CAMO_KEY"].present?
        generate_camo_uri(uri)
      else
        uri
      end
    end

    def self.generate_camo_uri(uri)
      digest = OpenSSL::Digest.new("sha1")
      hexdigest = OpenSSL::HMAC.hexdigest(digest, ENV["CAMO_KEY"], uri)
      encoded = uri.to_enum(:each_byte).map { |byte| format("%02x", byte) }.join
      "#{ENV['CAMO_HOST']}/#{hexdigest}/#{encoded}"
    end
  end
end

require_relative "./commands/dance_party"
require_relative "./commands/favstar"
require_relative "./commands/google_images"
require_relative "./commands/jesus"
require_relative "./commands/nope"
require_relative "./commands/pizza"
require_relative "./commands/pugs"
require_relative "./commands/urban_dictionary"
