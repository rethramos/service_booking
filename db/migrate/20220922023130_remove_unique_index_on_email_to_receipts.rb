class RemoveUniqueIndexOnEmailToReceipts < ActiveRecord::Migration[7.0]
  def change
    remove_index :receipts, column: :email
    add_index :receipts, :email
  end
end
