class CreatePaymentOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_options do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :payment_options, :name, unique: true
  end
end
