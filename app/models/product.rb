class Product < ApplicationRecord
  monetize :price_cents

  belongs_to :business
  has_many :provider_perks, foreign_key: "provided_product_id", class_name: "Perk"
  has_many :receiver_perks, foreign_key: "received_product_id", class_name: "Perk"
  has_many :purchases
  has_many :perks

  validates :name, presence: true
  validates :description, presence: true
  validates :price_cents, presence: true
  validates :category, presence: true
end
