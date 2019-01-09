class AddIsVisibleToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :is_visible, :boolean
  end
end
