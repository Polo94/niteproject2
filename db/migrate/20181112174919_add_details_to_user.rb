class AddDetailsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :user_name, :string
    add_column :users, :company_name, :string
    add_column :users, :location, :string
    add_column :users, :tel, :string
    add_column :users, :url, :string
  end
end
