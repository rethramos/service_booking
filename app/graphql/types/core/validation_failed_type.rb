# frozen_string_literal: true

module Types
  class Core::ValidationFailedType < Types::BaseObject
    field :errors, [Types::Core::ValidationErrorType], null: false

    def errors
      object.messages.map do |attribute, message|
        { attribute: attribute.to_s.camelize(:lower), message: message.first }
      end
    end
  end
end
