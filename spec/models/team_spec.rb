require "rails_helper"

RSpec.describe "Slack Teams", type: :model do
  it "can create and retrieve config vars" do
    team = Team.create(team_id: "T123YG08V")

    setting = team.setting_for("api-key")
    expect(setting.value).to eql(nil)
    setting.value = "sekret"
    setting.save


    team.reload
    setting = team.setting_for("api-key")
    expect(setting.value).to eql("sekret")
  end
end
