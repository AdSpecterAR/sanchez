class AdUnit < ApplicationRecord

  ### ASSOCIATIONS ###

  has_many :developer_apps, through: :impressions
  belongs_to :user

  ### VARIABLE DECLARATIONS ###

  FORMAT_IMAGE = 'image'
  FORMAT_VIDEO = 'video'
  FORMAT_PORTAL = 'portal'
  VALID_FORMATS = [
    FORMAT_IMAGE,
    FORMAT_VIDEO,
    FORMAT_PORTAL
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
  scope :rewarded, -> { where(rewarded: true) }
  scope :unrewarded, -> { where(rewarded: false, rewarded: nil) }
  scope :interstitial, -> { where(interstitial: true) }
  scope :noninterstitial, -> { where(interstitial: false, interstitial: nil) }


  ### VALIDATIONS ###

  validates :title, :ad_unit_url, :dimensions, presence: true
  validates :ad_format, inclusion: VALID_FORMATS, presence: true
  validates :dimensions, inclusion: VALID_DIMENSIONS, presence: true
  validates :ad_format, inclusion: [FORMAT_VIDEO], presence: true, if: :rewarded

  class << self
    def default_ad_unit
      # TODO: change
      AdUnit.first
    end

    def fetch_all(ad_format:, dimensions:)
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
          dimensions: dimensions
        )
    end

    def fetch(ad_format:, dimensions:)
      AdUnit.fetch_all(ad_format: ad_format, dimensions: dimensions).first
    end
  end
end
