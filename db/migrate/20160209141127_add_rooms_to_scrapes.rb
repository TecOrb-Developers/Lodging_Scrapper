class AddRoomsToScrapes < ActiveRecord::Migration
  def change
    add_column :scrapes, :rooms, :string
  end
end
