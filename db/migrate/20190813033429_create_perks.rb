class CreatePerks < ActiveRecord::Migration[5.2]
  def change
    create_table :perks do |t|
      t.string :kind
      t.integer :amount
      t.references :providing_business, index: true, foreign_key: { to_table: :businesses }
      t.references :providing_product, index: true, foreign_key: { to_table: :products }
      t.references :receiving_product, index: true, foreign_key: { to_table: :products }

      t.timestamps
    end
  end
end
