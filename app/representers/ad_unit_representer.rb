require 'representable/json'

class AdUnitRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :title
  property :description
  property :click_url
  property :ad_unit_url
  property :active
  property :ad_format
  property :dimensions
  property :aspect_ratio_width
  property :aspect_ratio_height
  property :last_served_at
  property :user
  property :created_at
  property :updated_at
end
