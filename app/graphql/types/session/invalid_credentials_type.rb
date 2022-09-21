# frozen_string_literal: true

module Types
  class Session::InvalidCredentialsType < Types::BaseObject
    field :message, String, null: false, fallback_value: 'Invalid credentials'
  end
end
