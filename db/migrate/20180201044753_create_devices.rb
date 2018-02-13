class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :device_model
      t.string :device_localized_model
      t.string :device_model_name
      t.string :device_name
      t.string :system_name
      t.string :system_version
      t.string :identifier_for_vendor

      t.timestamps
    end
  end
end
