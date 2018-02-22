class AddAdUnitToImpressions < ActiveRecord::Migration[5.1]
  def change
    add_reference :impressions, :ad_unit, foreign_key: true
  end
end
