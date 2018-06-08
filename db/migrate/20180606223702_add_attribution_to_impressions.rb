class AddAttributionToImpressions < ActiveRecord::Migration[5.1]
  def change
    add_column :impressions, :idfa, :string
    add_column :impressions, :country, :string

    add_column :ad_units, :attribution_partner, :string
    add_column :ad_units, :impression_url_ios, :string
    add_column :ad_units, :impression_url_android, :string
  end
end
