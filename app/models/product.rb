class Product < ApplicationRecord
  monetize :price_cents
  belongs_to :business
  has_many :providing_products, foreign_key: "providing_product_id", class_name: "Perk"
  has_many :receiving_products, foreign_key: "receiving_product_id", class_name: "Perk"
  has_many :purchases
  has_many :purks

  validates :name, presence: true
  validates :description, presence: true
  validates :price_cents, presence: true
  validates :category, presence: true
end
