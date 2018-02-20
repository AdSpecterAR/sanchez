class RemoveCampaignFromImpressions < ActiveRecord::Migration[5.1]
  def change
    remove_column :impressions, :campaign_id, :integer
  end
end
