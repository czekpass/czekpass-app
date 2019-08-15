class AddPerkIdToPurchase < ActiveRecord::Migration[5.2]
  def change
    add_reference :purchases, :perk
  end
end
