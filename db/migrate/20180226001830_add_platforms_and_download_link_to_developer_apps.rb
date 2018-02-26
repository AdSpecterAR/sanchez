class AddPlatformsAndDownloadLinkToDeveloperApps < ActiveRecord::Migration[5.1]
  def change
    add_column :developer_apps, :platform, :string
    add_column :developer_apps, :download_link, :string
  end
end
