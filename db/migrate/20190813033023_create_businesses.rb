class CreateBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :logo
      t.text :description
      t.string :location
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
