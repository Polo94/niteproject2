class CleanModels < ActiveRecord::Migration[5.2]
  def change
    remove_column :goods, :name
    remove_column :goods, :nickname
    remove_column :goods, :seller
    remove_column :goods, :tel
    remove_column :goods, :email
    remove_column :reviews, :title
    remove_column :reviews, :property_type
    remove_column :reviews, :location
    drop_table :opinions
    add_column :reviews, :recommendation, :text
    change_column :goods, :property_type, :integer
  end

  def data
    Good.all.each do |g|
      g.property_type = [0..4].sample
      g.save
    end
  end
end
