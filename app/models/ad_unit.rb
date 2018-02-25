class AdUnit < ApplicationRecord

  ### ASSOCIATIONS ###

  has_many :developer_apps, through: :impressions
  belongs_to :user

  ### VALIDATIONS ###

  validates :title, :ad_unit_url, presence: true

  class << self
    def default_ad_unit
      # TODO: change
      AdUnit.find(1)
    end
  end
end
