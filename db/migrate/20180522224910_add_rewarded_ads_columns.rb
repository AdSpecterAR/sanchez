class AddRewardedAdsColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :ad_units, :rewarded, :boolean
    add_column :ad_units, :interstitial, :boolean
    # video_length measured in milliseconds
    add_column :ad_units, :video_length, :integer
    add_column :impressions, :interaction_length, :integer
  end
end
