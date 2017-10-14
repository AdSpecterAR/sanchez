class Campaign < ApplicationRecord

  ### ASSOCIATIONS ###

  belongs_to :user

  ### VALIDATIONS ###

  validates :title, :ad_unit_url, presence: true
end
