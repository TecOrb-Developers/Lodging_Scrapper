class CreateScrapes < ActiveRecord::Migration
  def change
    create_table :scrapes do |t|
      t.string :name
      t.string :link
      t.string :rating
      t.string :s_address
      t.string :e_address
      t.string :city
      t.string :state
      t.string :pin
      t.string :star
      t.string :price
      t.string :total_reviews
      t.string :traveller_rating
      t.text :description
      t.text :amenities
      t.text :photos
      t.text :reviews

      t.timestamps null: false
    end
  end
end
