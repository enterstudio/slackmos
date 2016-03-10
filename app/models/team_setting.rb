# A config var for a team from the Slack API
class TeamSetting < ApplicationRecord
  belongs_to :team
end
