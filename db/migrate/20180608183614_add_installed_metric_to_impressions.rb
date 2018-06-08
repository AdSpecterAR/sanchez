class AddInstalledMetricToImpressions < ActiveRecord::Migration[5.1]
  def change
    add_column :impressions, :installed, :boolean
    add_column :impressions, :installed_at, :datetime
  end
end
