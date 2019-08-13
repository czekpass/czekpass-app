class AddDescriptionToPerks < ActiveRecord::Migration[5.2]
  def change
    add_column :perks, :description, :text
  end
end
