class AddSchema < ActiveRecord::Migration[5.0]
  def change
    enable_extension "plpgsql"
    enable_extension "uuid-ossp"

    create_table "commands", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.string   "args"
      t.string   "application"
      t.string   "channel_id",   null: false
      t.string   "channel_name", null: false
      t.string   "command",      null: false
      t.string   "command_text"
      t.string   "response_url", null: false
      t.string   "subtask"
      t.string   "task"
      t.string   "team_id",      null: false
      t.string   "team_domain",  null: false
      t.uuid     "user_id",      null: false
      t.datetime "processed_at"
      t.datetime "created_at",   null: false
      t.datetime "updated_at",   null: false
    end

    create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.string   "slack_user_id",            null: false
      t.string   "slack_user_name",          null: false
      t.string   "slack_team_id",            null: false
      t.datetime "created_at",               null: false
      t.datetime "updated_at",               null: false
    end

    add_foreign_key "commands", "users"
  end
end
