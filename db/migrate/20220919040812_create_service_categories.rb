class CreateServiceCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :service_categories do |t|
      t.references :business, null: false
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
