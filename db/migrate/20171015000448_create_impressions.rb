class CreateImpressions < ActiveRecord::Migration[5.1]
  def change
    create_table :impressions do |t|
      t.datetime :impression_started_at
      t.datetime :impression_ended_at
      t.boolean :clicked
      t.references :developer_app, index: true, foreign_key: true
      t.references :campaign, index: true, foreign_key: true

      t.timestamps
    end
  end
end
