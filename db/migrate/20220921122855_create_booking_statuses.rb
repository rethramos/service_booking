class CreateBookingStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :booking_statuses do |t|
      t.string :type, null: false

      t.timestamps
    end

    add_index :booking_statuses, :type, unique: true
  end
end
