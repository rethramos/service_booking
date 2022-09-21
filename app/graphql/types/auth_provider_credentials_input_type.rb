# frozen_string_literal: true

module Types
  class AuthProviderCredentialsInputType < Types::BaseInputObject
    argument :email, String, required: true
    argument :password, String, required: true
  end
end
