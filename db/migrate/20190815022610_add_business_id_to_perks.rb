class AddBusinessIdToPerks < ActiveRecord::Migration[5.2]
  def change
    add_reference :perks, :business, foreign_key: true
  end
end
