class RemoveIndexOnCartAndServiceToCartItems < ActiveRecord::Migration[7.0]
  def change
    remove_index :cart_items, column: %i[cart_id service_id]
    add_index :cart_items, %i[cart_id service_id appointment_id],
                           unique: true
  end
end
