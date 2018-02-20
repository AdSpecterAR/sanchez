class AddAdUnitToImpressions < ActiveRecord::Migration[5.1]
  def change
    add_column :impressions, :ad_unit_id, :integer
    add_index :impressions, :ad_unit_id
    add_foreign_key :impressions, :ad_units
  end
end
