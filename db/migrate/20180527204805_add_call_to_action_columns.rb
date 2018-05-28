class AddCallToActionColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :ad_units, :click_url, :click_url_default
    add_column :ad_units, :click_url_android, :string
    add_column :ad_units, :click_url_ios, :string
    add_column :ad_units, :click_to_action, :string
  end
end
