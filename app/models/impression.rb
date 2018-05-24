class Impression < ApplicationRecord

  ### ASSOCIATIONS ###

  belongs_to :developer_app
  belongs_to :ad_unit
  belongs_to :app_session


  ### VALIDATIONS ###

  # TODO: change
  def serve_ad_unit(time)
    self.ad_unit.update_attributes(title: 'yo')
  end

  def ratio_interacted
    return nil if self.interaction_length.nil? || self.ad_unit.video_length.nil? || self.ad_unit.video_length <= 0

    if self.ad_unit.rewarded
      self.interaction_length.to_f / self.ad_unit.video_length.to_f
    end
  end
end

# DESIRED
# developer_app has many app_sessions
# app_sessions has_many impressions
# developer_app has_many impressions :through app_sessions


# CURRENT
# app_session has_many impressions
# developer_app has many app_sessions
