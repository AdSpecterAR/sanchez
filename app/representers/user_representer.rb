require 'representable/json'

class UserRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true

  property :id
  property :first_name
  property :last_name
  property :full_name
  property :account_type
  property :username
  property :email
end
