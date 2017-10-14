class AddDeveloperAppsToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :api_keys, :developer_app, foreign_key: true
    add_reference :developer_apps, :user, foreign_key: true
  end
end
