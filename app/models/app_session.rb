class AppSession < ApplicationRecord

  has_one :device
  has_one :developer_app
  has_many :impressions

end
