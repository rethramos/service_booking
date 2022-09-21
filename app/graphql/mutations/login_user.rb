module Mutations
  class LoginUser < BaseMutation
    argument :credentials, Types::AuthProviderCredentialsInputType, required: true

    type Types::Session::LoginUserResultType, null: false

    def resolve(credentials: nil)
      user = User.find_by(email: credentials[:email])
      if user && user.authenticate(credentials[:password])
        user
      else
        :invalid_credentials
      end
    end
  end
end
