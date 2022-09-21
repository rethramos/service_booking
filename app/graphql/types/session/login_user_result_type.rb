# frozen_string_literal: true

module Types
  class Session::LoginUserResultType < Types::BaseUnion
    possible_types Types::Session::LoginUserPayloadType,
                   Types::Session::InvalidCredentialsType

    def self.resolve_type(object, _context)
      if object.is_a? ::User
        Types::Session::LoginUserPayloadType
      else
        Types::Session::InvalidCredentialsType
      end
    end
  end
end
