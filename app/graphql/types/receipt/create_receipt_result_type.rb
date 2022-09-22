# frozen_string_literal: true

module Types
  class Receipt::CreateReceiptResultType < Types::BaseUnion
    possible_types Types::ReceiptType, Types::Core::ValidationFailedType,
                   Types::Auth::UnauthenticatedType

    def self.resolve_type(object, _context)
      if object.is_a? ::Receipt
        Types::ReceiptType
      elsif object.is_a? ActiveModel::Errors
        Types::Core::ValidationFailedType
      else
        Types::Auth::UnauthenticatedType
      end
    end
  end
end
