class AddTeamDomain < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :team_domain, :string, null: true
  end
end
