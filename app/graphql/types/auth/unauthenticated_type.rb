# frozen_string_literal: true

module Types
  class Auth::UnauthenticatedType < Types::BaseObject
    field :message, String, null: false, fallback_value: 'Please log in.'

  end
end
