require 'representable/json'

class CampaignRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :title
  property :description
  property :click_url
  property :ad_unit_url
  property :active
  property :created_at
  property :updated_at
end
