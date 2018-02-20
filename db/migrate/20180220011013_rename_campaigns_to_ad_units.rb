class RenameCampaignsToAdUnits < ActiveRecord::Migration[5.1]
  def change
    rename_table :campaigns, :ad_units
  end
end
