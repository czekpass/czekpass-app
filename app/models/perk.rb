class Perk < ApplicationRecord
  belongs_to :providing_business, class_name: "Business"
  belongs_to :providing_product, class_name: "Product"
  belongs_to :receiving_product, class_name: "Product"
end
