class Perk < ApplicationRecord
  belongs_to :patronized_business, class_name: "Business"
  belongs_to :purchased_product, class_name: "Product"
  belongs_to :product
  belongs_to :business

  validates :description, presence: true
  validates :kind, presence: true
  validates :amount, presence: true
end
