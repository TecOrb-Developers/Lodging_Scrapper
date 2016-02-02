class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :total

      t.timestamps null: false
    end
  end
end
