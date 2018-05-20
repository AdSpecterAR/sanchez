class AdUnit < ApplicationRecord

  ### ASSOCIATIONS ###

  has_many :developer_apps, through: :impressions
  belongs_to :user

  ### VARIABLE DECLARATIONS ###

  FORMAT_IMAGE = 'image'
  FORMAT_VIDEO = 'video'
  VALID_FORMATS = [
    FORMAT_IMAGE,
    FORMAT_VIDEO
  ]

  DIMENSIONS_16_BY_9 = '16:9'
  DIMENSIONS_4_BY_3 = '4:3'
  DIMENSIONS_1_BY_1 = '1:1'
  VALID_DIMENSIONS = [
    DIMENSIONS_16_BY_9,
    DIMENSIONS_4_BY_3,
    DIMENSIONS_1_BY_1
  ]

  ### SCOPES ###

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  ### VALIDATIONS ###

  validates :title, :ad_unit_url, :dimensions, presence: true
  validates :format, inclusion: VALID_FORMATS, presence: true
  validates :dimensions, inclusion: VALID_DIMENSIONS, presence: true

  class << self
    def default_ad_unit
      # TODO: change
      AdUnit.first
    end

    def fetch_all(format:, dimensions:)
      # TODO: if used directly from controller, add maximum
      # number of ads to query and revisit 'where'
      AdUnit
        .active
        .order('last_served_at asc')
        .includes([:user])
        .where(
          format: format,
          dimensions: dimensions
        )
    end

    def fetch(format:, dimensions:)
      AdUnit.fetch_all(format: format, dimensions: dimensions).first
    end
  end
end
