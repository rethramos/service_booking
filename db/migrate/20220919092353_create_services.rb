class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.references :business, null: false, foreign_key: true
      t.references :service_category, foreign_key: true
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :unit_price, null: false, precision: 10, scale: 2
      t.string :currency, null: false, default: 'PHP'

      t.timestamps
    end

    add_index :services, [:business_id, :name], unique: true
  end
end
