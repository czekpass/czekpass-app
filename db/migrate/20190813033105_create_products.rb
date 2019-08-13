class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price_cents
      t.string :category
      t.string :photo
      t.references :business, foreign_key: true

      t.timestamps
    end
  end
end
