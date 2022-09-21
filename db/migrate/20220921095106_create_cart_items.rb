class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.references :appointment, null: false, foreign_key: true
      t.text :addon
      t.integer :slots, null: false

      t.timestamps
    end

    add_index :cart_items, %i[cart_id service_id], unique: true
  end
end
