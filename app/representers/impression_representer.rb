require 'representable/json'

class ImpressionRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :impression_started_at
  property :impression_ended_at
  property :served
  property :served_at
  property :shown
  property :shown_at
  property :clicked
  property :clicked_at
  property :developer_app
  property :ad_unit
  property :app_session
  property :created_at
  property :updated_at
end
