class AddReviewReferencesToGoods < ActiveRecord::Migration[5.2]
  def change
    rename_column :goods, :seller, :is_seller
    add_reference :goods, :seller, foreign_key: {to_table: :reviews}, null: true
    add_reference :goods, :buyer, foreign_key: {to_table: :reviews}, null: true
  end
end
