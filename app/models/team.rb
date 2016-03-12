# A team from the Slack API
class Team < ApplicationRecord
  has_many :commands, -> { order "created_at desc" }, primary_key: :team_id
  has_many :team_settings, dependent: :destroy
  validates :team_id, uniqueness: true

  def setting(key)
    team_settings.find_or_initialize_by(key: key)
  end

  def value(key)
    setting(key).value
  end

  def copy_google_config_from(other_team)
    setting = setting("GOOGLE_CSE_ID")
    setting.value = other_team.google_cse_id
    setting.save

    setting = setting("GOOGLE_CSE_KEY")
    setting.value = other_team.google_cse_key
    setting.save
  end

  def google_cse_id
    value("GOOGLE_CSE_ID")
  end

  def google_cse_key
    value("GOOGLE_CSE_KEY")
  end

  def google_cse_safe_search
    safe = value("GOOGLE_SAFE_SEARCH")
    safe if safe && !safe.empty?
  end

  def google_cse_configured?
    response = client.get do |request|
      request.url "/customsearch/v1"
      request.params = google_cse_params
      request.headers["Content-Type"] = "application/json"
    end
    response_body = JSON.load(response.body)
    !response_body["items"].nil? && !response_body["items"].empty?
  rescue StandardError
    false
  end

  def google_cse_params
    {
      q: "the linux kernel",
      cx:  google_cse_id,
      key: google_cse_key,
      num: 5,
      searchType: "image"
    }
  end

  def client
    @client ||= Faraday.new(url: "https://www.googleapis.com")
  end

  def self.verify_teams
    Team.all.map do |team|
      [
        team.team_id,
        team.team_domain,
        team.google_cse_configured?,
        team.google_cse_id,
        team.google_cse_key
      ]
    end
  end
end
