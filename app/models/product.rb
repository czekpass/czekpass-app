class Product < ApplicationRecord
  belongs_to :business
  # using a class name "Perk" because rails can't infer that this is a "Perk" from the association name.
  # eg Every product has a supplier ID associated with the business_id - class_name: 'Business'
  has_many :provider_perks, foreign_key: "provided_product_id", class_name: "Perk"
  has_many :receiver_perks, foreign_key: "received_product_id", class_name: "Perk"
  has_many :purchases

  validates :name, presence: true
  validates :description, presence: true
  validates :price_cents, presence: true
  validates :category, presence: true
end
