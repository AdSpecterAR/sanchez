require 'representable/json'

class ImpressionRepresentable < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :impression_started_at
  property :impression_ended_at
  property :clicked
  property :developer_app
  property :campaign
  property :created_at
  property :updated_at
end
