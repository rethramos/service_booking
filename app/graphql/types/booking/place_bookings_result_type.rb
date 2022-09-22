# frozen_string_literal: true

module Types
  class Booking::PlaceBookingsResultType < Types::BaseUnion
    possible_types Types::ReceiptType, Types::Core::ValidationFailedType,
                   Types::Auth::UnauthenticatedType

    def self.resolve_type(object, _context)
      if object.is_a? ::Receipt
        Types::ReceiptType
      elsif object.is_a? ActiveModel::Errors
        Types::Core::ValidationFailedType
      elsif object == :unauthenticated
        Types::Auth::UnauthenticatedType
      end
    end
  end
end
