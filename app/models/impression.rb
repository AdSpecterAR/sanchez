class Impression < ApplicationRecord

  ### ASSOCIATIONS ###

  # belongs_to :developer_app
  belongs_to :ad_unit
  belongs_to :app_session


  ### VALIDATIONS ###


  class << self
    def ratio_interacted
      return if @impression.ad_unit.video_length? || @impression.ad_unit.video_length <= 0

      if @impression.ad_unit.rewarded
        return @impression.interaction_length.to_f / @impression.ad_unit.video_length.to_f
      end
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
#