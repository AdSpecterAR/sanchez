require 'representable/json'

class DeveloperAppRepresentable < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :name
  property :client_api_key
  property :user
  property :created_at
  property :updated_at
end
