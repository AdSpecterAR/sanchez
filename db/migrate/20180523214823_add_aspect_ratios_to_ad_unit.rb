class AddAspectRatiosToAdUnit < ActiveRecord::Migration[5.1]
  def change
    remove_column :ad_units, :dimensions, :string
    add_column :ad_units, :aspect_ratio_width, :integer
    add_column :ad_units, :aspect_ratio_height, :integer
  end
end
