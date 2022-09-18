class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :timezone, null: false, default: 'UTC'

      t.timestamps
    end
  end
end
