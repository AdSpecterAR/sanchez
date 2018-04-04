class Impression < ApplicationRecord

  ### ASSOCIATIONS ###

  # belongs_to :developer_app
  belongs_to :ad_unit
  belongs_to :app_session


  ### VALIDATIONS ###
end

# DESIRED
# developer_app has many app_sessions
# app_sessions has_many impressions
# developer_app has_many impressions :through app_sessions


# CURRENT
# app_session has_many impressions
# developer_app has many app_sessions
#