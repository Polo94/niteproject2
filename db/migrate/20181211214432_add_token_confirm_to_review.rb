class AddTokenConfirmToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :token_confirm, :string
  end
end
