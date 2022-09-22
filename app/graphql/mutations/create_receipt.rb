module Mutations
  class CreateReceipt < BaseMutation

    argument :payment_option_id, ID, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :email, String, required: true
    argument :contact_number, String, required: true
    argument :address, Types::Address::AddressInputType, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
  end
end
