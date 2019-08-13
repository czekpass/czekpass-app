class CreateBusinessCategoryTags < ActiveRecord::Migration[5.2]
  def change
    create_table :business_category_tags do |t|
      t.references :business_category, foreign_key: true
      t.references :business, foreign_key: true

      t.timestamps
    end
  end
end
