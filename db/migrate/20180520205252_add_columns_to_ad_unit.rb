class AddColumnsToAdUnit < ActiveRecord::Migration[5.1]
  def change
    add_column :ad_units, :dimensions, :string
    add_column :ad_units, :ad_format, :string
    add_column :ad_units, :last_served_at, :datetime
  end
end
