class DeveloperApp < ApplicationRecord

  ### ASSOCIATIONS ###

  has_one :api_key
  has_many :campaigns, through: :impressions

  belongs_to :user


  ### VALIDATIONS ###

  validates :user, :name, presence: true

  ### INSTANCE METHODS ###

  def client_api_key
    "#{api_key.key}"
  end
end