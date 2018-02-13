class AddForeignKeysToImpressionsAndDevices < ActiveRecord::Migration[5.1]
  def change
    add_reference :impressions, :app_session, index: true
    add_reference :devices, :app_session, index: true

    add_foreign_key :impressions, :app_sessions
    add_foreign_key :devices, :app_sessions
  end
end
