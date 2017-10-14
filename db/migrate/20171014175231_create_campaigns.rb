class CreateCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :description
      t.string :click_url
      t.string :ad_unit_format
      t.string :ad_unit_url
      t.boolean :active

      t.timestamps
    end
  end
end
