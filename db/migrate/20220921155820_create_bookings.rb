class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :receipt, null: false, foreign_key: true
      t.references :service, foreign_key: true
      t.references :booking_status, foreign_key: true
      t.string :service_name, null: false
      t.datetime :service_appointment, null: false
      t.decimal :service_unit_price, null: false, precision: 10, scale: 2
      t.string :service_currency, null: false
      t.integer :slots, null: false
      t.text :addon

      t.timestamps
    end
  end
end
