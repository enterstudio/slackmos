# A team from the Slack API
class Team < ApplicationRecord
  has_many :team_settings, dependent: :destroy

  def setting(key)
    team_settings.find_or_initialize_by(key: key)
  end

  def value(key)
    setting(key).value
  end
end
