class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :service, null: false, foreign_key: true
      t.datetime :timeslot, null: false
      t.integer :max_slots, null: false

      t.timestamps
    end

    add_index :appointments, %i[service_id timeslot], unique: true
  end
end
