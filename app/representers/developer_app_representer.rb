require 'representable/json'

class DeveloperAppRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :name
  property :developer_key
  property :user
  property :created_at
  property :updated_at
end
