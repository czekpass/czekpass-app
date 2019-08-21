class AddDiscountedPriceToPerks < ActiveRecord::Migration[5.2]
  def change
    add_column :perks, :discounted_price, :integer
  end
end
