class CreatePerkTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :perk_templates do |t|
      t.text :description
      t.integer :amount
      t.string :kind
      t.references :business, foreign_key: true
      t.references :receiving_product, index: true, foreign_key: { to_table: :products }

      t.timestamps
    end
  end
end
