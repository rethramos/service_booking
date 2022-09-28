# frozen_string_literal: true

module Types
  class Cart::DeleteCartResultType < Types::BaseUnion
    possible_types Types::Boolean, Types::Auth::UnauthenticatedType

    def self.resolve_type(object, _context)
      if object === :unauthenticated
        Types::Auth::UnauthenticatedType
      elsif object.is_a? ActiveModel::Errors
        Types::Core::ValidationFailedType
      else
        Types::Boolean
      end
    end
  end
end
