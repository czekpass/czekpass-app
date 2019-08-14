class AddCategoryReferencesToBusiness < ActiveRecord::Migration[5.2]
  def change
    add_reference :businesses, :business_category, foreign_key: true
  end
end
