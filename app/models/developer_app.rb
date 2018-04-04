class DeveloperApp < ApplicationRecord

  ### ASSOCIATIONS ###

  has_one :api_key
  has_many :ad_units, through: :impressions # remove???
  has_many :app_sessions
  has_many :impressions, through: :app_sessions

  belongs_to :user

  PLATFORM_IOS = 'iOS'
  PLATFORM_ANDROID = 'Android'
  PLATFORM_WINDOWS = 'Windows'
  PLATFORM_UNITY = 'Unity'
  VALID_PLATFORMS = [
    PLATFORM_IOS,
    PLATFORM_ANDROID,
    PLATFORM_WINDOWS,
    PLATFORM_UNITY
  ]
  
  ### VALIDATIONS ###

  validates :name, presence: true
  validates :platform, presence: true, inclusion: {in: VALID_PLATFORMS}

  ### INSTANCE METHODS ###

  def client_api_key
    "#{api_key.key}"
  end
end
