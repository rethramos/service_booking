# frozen_string_literal: true

module Types
  class User::CreateUserResultType < Types::BaseUnion
    possible_types Types::User::CreateUserPayloadType, Types::Core::ValidationFailedType

    def self.resolve_type(object, _context)
      if object.is_a? ::User
        Types::User::CreateUserPayloadType
      else
        Types::Core::ValidationFailedType
      end
    end
  end
end
