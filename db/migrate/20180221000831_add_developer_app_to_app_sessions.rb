class AddDeveloperAppToAppSessions < ActiveRecord::Migration[5.1]
  def change
      add_reference :app_sessions, :developer_app, foreign_key: true
  end
end
