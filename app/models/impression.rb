class Impression < ApplicationRecord

  ### ASSOCIATIONS ###

  belongs_to :developer_app
  belongs_to :campaign
  belongs_to :app_session


  ### VALIDATIONS ###

  validates :developer_app, presence: true
end
