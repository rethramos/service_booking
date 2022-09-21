# frozen_string_literal: true

module Types
  class User::CreateUserPayloadType < Types::BaseObject
    field :user, Types::UserType, null: false

    def user
      object
    end

  end
end
