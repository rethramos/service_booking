module Mutations
  class AddToCart < BaseMutation
    argument :service_id, ID, required: true
    argument :appointment_id, ID, required: true
    argument :addon, String, required: false
    argument :slots, Integer, required: true

    type Types::Cart::AddToCartResultType, null: false

    def resolve(args = {})
      return :unauthenticated unless (user = context[:current_user])

      cart_item = user.cart.cart_items.find_or_initialize_by(
        service_id: args[:service_id],
        appointment_id: args[:appointment_id]
      )
      cart_item.addon = args[:addon]
      cart_item.slots = args[:slots]
      
      if cart_item.save
        cart_item
      else
        cart_item.errors
      end
    end
  end
end
