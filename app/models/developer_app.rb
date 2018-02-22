class DeveloperApp < ApplicationRecord

  ### ASSOCIATIONS ###

  has_one :api_key
  has_many :ad_units, through: :impressions
  has_many :app_sessions

  belongs_to :user


  ### VALIDATIONS ###

  validates :user, :name, presence: true

  ### INSTANCE METHODS ###

  def client_api_key
    "#{api_key.key}"
  end
end
