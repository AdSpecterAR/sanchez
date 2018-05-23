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

  DIMENSIONS_16_BY_9 = [16,9]
  DIMENSIONS_9_BY_16 = [9,16]
  DIMENSIONS_1_BY_1 = [1,1]
  VALID_DIMENSIONS = [
    DIMENSIONS_16_BY_9,
    DIMENSIONS_9_BY_16,
    DIMENSIONS_1_BY_1
  ]

  ### SCOPES ###

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  ### VALIDATIONS ###

  validates :title, :ad_unit_url, :aspect_ratio_width, :aspect_ratio_height, presence: true
  validates :ad_format, inclusion: VALID_FORMATS, presence: true
  # validates :dimensions, inclusion: VALID_DIMENSIONS, presence: true

  class << self
    def default_ad_unit
      # TODO: change
      AdUnit.first
    end

    def fetch_all(ad_format:, aspect_ratio_width:, aspect_ratio_height:)
      # TODO: if used directly from controller, add maximum
      # number of ads to query and revisit 'where'
      AdUnit
        .active
        .order(%q{
          CASE
          WHEN last_served_at IS NULL THEN 1
          ELSE 0 END DESC,
          last_served_at ASC
        })
        .includes([:user])
        .where(
          ad_format: ad_format,
          aspect_ratio_width: aspect_ratio_width,
          aspect_ratio_height: aspect_ratio_height,
        )
    end

    def fetch(ad_format:, aspect_ratio_width:, aspect_ratio_height:)
      AdUnit.fetch_all(
        ad_format: ad_format,
        aspect_ratio_width: aspect_ratio_width,
        aspect_ratio_height: aspect_ratio_height
      ).first
    end
  end

  def dimensions
    "#{aspect_ratio_width}:#{aspect_ratio_height}"
  end
end
