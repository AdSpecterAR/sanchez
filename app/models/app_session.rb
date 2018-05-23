class AppSession < ApplicationRecord

  has_one :device
  has_many :impressions

  belongs_to :developer_app
end
