class CreateGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :goods do |t|
      t.string :title
      t.string :name
      t.string :nickname
      t.boolean :seller
      t.string :property_type
      t.string :location
      t.string :tel
      t.string :email
      t.integer :user_id

      t.timestamps
    end
  end
end
