module Mutations
  class DeleteCartItem < BaseMutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    argument :cart_item_id, ID, required: true

    type Boolean, null: false

    # TODO: define resolve method
    def resolve(cart_item_id:)
      return false unless (user = context[:current_user])

      cart_item = user.cart.cart_items.find_by(id: cart_item_id)
      if cart_item.nil?
        false
      else
        cart_item.destroy
        true
      end
    end
  end
end
