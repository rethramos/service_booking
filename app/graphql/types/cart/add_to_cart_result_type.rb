# frozen_string_literal: true

module Types
  class Cart::AddToCartResultType < Types::BaseUnion
    possible_types Types::CartItemType, Types::Core::ValidationFailedType,
                   Types::Auth::UnauthenticatedType

    def self.resolve_type(object, _context)
      if object.is_a? ::CartItem
        Types::CartItemType
      elsif object.is_a? ActiveModel::Errors
        Types::Core::ValidationFailedType
      else
        Types::Auth::UnauthenticatedType
      end
    end
  end
end
