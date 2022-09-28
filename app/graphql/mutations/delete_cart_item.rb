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
      unless cart_item.nil?
        cart_item.destroy
        true
      end
      false
    end
  end
end
