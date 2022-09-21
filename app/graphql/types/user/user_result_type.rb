# frozen_string_literal: true

module Types
  class User::UserResultType < Types::BaseUnion
    possible_types Types::UserType, Types::Auth::UnauthenticatedType
    
    def self.resolve_type(object, context)
      if object.is_a? ::User
        Types::UserType
      elsif object == :unauthenticated
        Types::Auth::UnauthenticatedType
      end
    end

  end
end
