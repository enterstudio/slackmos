class RemoveCommandsUsersFk < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key "commands", "users"
    add_column :commands, :slack_user_id, :string, null: true
    change_column :commands, :user_id, :uuid, null: true
  end
end
