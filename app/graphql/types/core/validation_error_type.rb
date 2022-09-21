# frozen_string_literal: true

module Types
  class Core::ValidationErrorType < Types::BaseObject
    field :attribute, String, null: false
    field :message, String, null: false
  end
end
