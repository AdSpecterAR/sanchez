class Impression < ApplicationRecord

  ### ASSOCIATIONS ###

  belongs_to :developer_app
  belongs_to :campaign


  ### VALIDATIONS ###

  validates :developer_app, :campaign, :impression_started_at, :impression_ended_at, presence: true
end
