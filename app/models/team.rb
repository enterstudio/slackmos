# A team from the Slack API
class Team < ApplicationRecord
  has_many :team_settings, dependent: :destroy

  def setting_for(key)
    team_settings.find_or_create_by(key: key)
  end
end
