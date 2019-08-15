class ChangePerkTemplateReceivingProductIdToProductId < ActiveRecord::Migration[5.2]
  def change
    rename_column :perk_templates, :receiving_product_id, :product
  end
end
