class Impression < ApplicationRecord

  ### ASSOCIATIONS ###

  belongs_to :developer_apps
  belongs_to :campaigns


  ### VALIDATIONS ###

  validates :developer_app, :campaign, :impressions_started_at, :impressions_ended_at, presence: true
end
