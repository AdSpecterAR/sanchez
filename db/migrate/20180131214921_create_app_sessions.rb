class CreateAppSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :app_sessions do |t|
      t.timestamps
    end
  end
end
