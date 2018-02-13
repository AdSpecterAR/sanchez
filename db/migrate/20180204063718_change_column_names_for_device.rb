class ChangeColumnNamesForDevice < ActiveRecord::Migration[5.1]
  def change
    rename_column :devices, :device_name, :name
    rename_column :devices, :device_localized_model, :localized_model
  end
end
