class Campaign < ApplicationRecord

  ### ASSOCIATIONS ###

  has_many :developer_apps, through: :impressions
  belongs_to :user

  ### VALIDATIONS ###

  validates :title, :ad_unit_url, presence: true
end
