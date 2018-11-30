class AddInfosToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :title, :string
    add_column :reviews, :name, :string
    add_column :reviews, :nickname, :string
    add_column :reviews, :property_type, :string
    add_column :reviews, :location, :string
    add_column :reviews, :tel, :string
    add_column :reviews, :email, :string

  end
end
