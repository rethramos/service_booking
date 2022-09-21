class CreateBookingStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :booking_statuses do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :booking_statuses, :name, unique: true
  end
end
