class CreateDeveloperApps < ActiveRecord::Migration[5.1]
  def change
    create_table :developer_apps do |t|
      t.string :name

      t.timestamps
    end
  end
end
