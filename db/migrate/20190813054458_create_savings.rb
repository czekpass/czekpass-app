class CreateSavings < ActiveRecord::Migration[5.2]
  def change
    create_table :savings do |t|
      t.string :kind
      t.integer :amount
      t.references :perk, foreign_key: true
      t.references :purchase, foreign_key: true

      t.timestamps
    end
  end
end
