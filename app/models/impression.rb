class Impression < ApplicationRecord

  ### ASSOCIATIONS ###

  belongs_to :developer_app
  belongs_to :ad_unit
  belongs_to :app_session


  ### VALIDATIONS ###

  validates :developer_app, presence: true
end
