class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true, null: false
      t.string :line_one, null: false
      t.string :line_two, null: false
      t.string :city, null: false
      t.string :province, null: false
      t.string :country, null: false
      t.string :postal_code, null: false

      t.timestamps
    end
  end
end
