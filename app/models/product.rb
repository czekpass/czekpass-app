class Product < ApplicationRecord
  belongs_to :business
  has_many :provider_perks, foreign_key: "provided_product_id", class_name: "Perk"
  has_many :receiver_perks, foreign_key: "received_product_id", class_name: "Perk"
  has_many :purchases
end
