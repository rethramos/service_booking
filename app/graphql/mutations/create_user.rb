# frozen_string_literal: true

module Mutations
  class CreateUser < BaseMutation
    class Types::AuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInputType, required: true
      argument :password_confirmation, String, required: true
    end

    description 'Creates a new user'

    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :timezone, String, required: true, default_value: 'UTC'
    argument :auth_provider, Types::AuthProviderSignupData, required: true

    type Types::User::CreateUserResultType, null: false

    def resolve(first_name:, last_name:, timezone:, auth_provider:)
      user = ::User.new(
        first_name:,
        last_name:,
        timezone:,
        email: auth_provider&.[](:credentials)&.[](:email),
        password: auth_provider&.[](:credentials)&.[](:password),
        password_confirmation: auth_provider[:password_confirmation]
      )

      if user.save
        context[:session][:user_id] = user.id
        user
      else
        user.errors
      end
    end
  end
end
