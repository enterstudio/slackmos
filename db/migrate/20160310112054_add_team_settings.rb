class AddTeamSettings < ActiveRecord::Migration[5.0]
  def change
    create_table "teams", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.string "team_id", null: false
    end

    create_table "team_settings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
      t.uuid     "team_id",      null: false
      t.string   "key",          null: false
      t.string   "value",        null: true
      t.datetime "created_at",   null: false
      t.datetime "updated_at",   null: false
    end

    add_foreign_key "team_settings", "teams"
    add_index "team_settings", ["key", "team_id"], name: "team_keys", using: :btree
  end
end
