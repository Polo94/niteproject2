class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.float :stars
      t.float :service_quality
      t.float :interlocutor_skills
      t.float :monitoring_care
      t.boolean :company_recommendation
      t.text :testimony, limit: 250
      t.string :token
      

      t.timestamps
    end
  end
end
