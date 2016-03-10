require "rails_helper"

RSpec.describe "Heroku app.json", type: :model do
  it "app.json file is valid JSON" do
    expect do
      JSON.load(File.read(File.join(Rails.root, "app.json")))
    end.to_not raise_error
  end
end
