class ChangeProvidingReceivingNamesOnPerks < ActiveRecord::Migration[5.2]
  def change
    rename_column :perks, :providing_business_id, :patronized_business_id
    rename_column :perks, :providing_product_id, :purchased_product_id
    rename_column :perks, :receiving_product_id, :product_id
  end
end
