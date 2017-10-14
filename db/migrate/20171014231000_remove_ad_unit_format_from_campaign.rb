class RemoveAdUnitFormatFromCampaign < ActiveRecord::Migration[5.1]
  def change
    remove_column :campaigns, :ad_unit_format, :string
  end
end
