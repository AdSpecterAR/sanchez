class AddTelemetryToImpressions < ActiveRecord::Migration[5.1]
  def change
    add_column :impressions, :shown_at, :datetime
    add_column :impressions, :served_at, :datetime
    add_column :impressions, :shown_for_30_seconds_at, :datetime
    add_column :impressions, :clicked_at, :datetime
    add_column :impressions, :served, :boolean
    add_column :impressions, :shown, :boolean
    add_column :impressions, :shown_for_30_seconds, :boolean
  end
end
