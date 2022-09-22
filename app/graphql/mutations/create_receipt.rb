module Mutations
  class CreateReceipt < BaseMutation
    argument :payment_option_id, ID, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :email, String, required: true
    argument :contact_number, String, required: true
    argument :address, Types::Address::AddressInputType, required: true

    type Types::Receipt::CreateReceiptResultType, null: false

    def resolve(
      payment_option_id:,
      first_name:,
      last_name:,
      email:,
      contact_number:,
      address:
    )

      return :unauthenticated unless (user = context[:current_user])
      receipt = user.receipts.build(
        payment_option_id:,
        first_name:,
        last_name:,
        email:,
        contact_number:,   
      )
      receipt.build_address(**address)

      if receipt.save
        receipt
      else
        receipt.errors
      end
    end
  end
end
