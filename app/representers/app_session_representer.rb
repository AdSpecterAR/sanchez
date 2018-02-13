require 'representable/json'

class AppSessionRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :created_at
  property :updated_at
end
