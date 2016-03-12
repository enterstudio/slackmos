# Module for containing all app specific stuff
module Slackmos
  def self.encode_origin(origin)
    Base64.encode64(JSON.dump(origin)).split("\n").join("")
  end

  def self.decode_origin(origin)
    JSON.parse(Base64.decode64(origin)).with_indifferent_access
  end
end

require_relative "./slackmos/commands"
