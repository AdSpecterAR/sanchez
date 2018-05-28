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
  CTA_LEARN_MORE = 'Learn More'
  CTA_DOWNLOAD = 'Download'
  CTA_GET_OFFER = 'Get Offer'
  CTA_PLAY_GAME = 'Play Game'
  CTA_SHOP_NOW = 'Shop Now'
  CTA_SIGN_UP = 'Sign Up'
  CTA_SUBSCRIBE = 'Subscribe'
  CTA_WATCH_MORE = 'Watch More'
  CTA_NO_BUTTON = 'No Button'
  VALID_CALLS_TO_ACTION = [
    CTA_LEARN_MORE,
    CTA_DOWNLOAD,
    CTA_GET_OFFER,
    CTA_PLAY_GAME,
    CTA_SHOP_NOW,
    CTA_SIGN_UP,
    CTA_SUBSCRIBE,
    CTA_WATCH_MORE,
    CTA_NO_BUTTON
  ]

  # TODO: Add valid aspect ratios

  ### SCOPES ###

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :rewarded, -> { where(rewarded: true) }
  scope :unrewarded, -> { where(rewarded: false) }
  scope :interstitial, -> { where(interstitial: true) }
  scope :noninterstitial, -> { where(interstitial: false) }


  ### VALIDATIONS ###

  validates :title, :ad_unit_url, :aspect_ratio_width, :aspect_ratio_height, :click_url_default, presence: true
  validates :ad_format, inclusion: VALID_FORMATS, presence: true
  validates :ad_format, inclusion: [FORMAT_VIDEO], presence: true, if: :rewarded
  validates :call_to_action, inclusion: VALID_CALLS_TO_ACTION, presence: true

  # TODO: validate aspect ratios
  #
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
      ).take
    end
  end

  def dimensions
    "#{aspect_ratio_width}:#{aspect_ratio_height}"
  end
end
