class Perk < ApplicationRecord
  # Again here we use the class_name so that rails can infer that these are 'Business' and 'Product' instances.
  belongs_to :providing_business, class_name: "Business"
  belongs_to :providing_product, class_name: "Product"
  belongs_to :receiving_product, class_name: "Product"

  validates :description, presence: true
  validates :kind, presence: true
  validates :amount, presence: true
end
