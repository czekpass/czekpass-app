class Product < ApplicationRecord
  monetize :price_cents
  belongs_to :business

  # I don't understand these validations.
  # has_many :providing_products, foreign_key: "providing_product_id", class_name: "Perk"
  # has_many :receiving_products, foreign_key: "receiving_product_id", class_name: "Perk"
  has_many :purchases

  has_many :perks, foreign_key: "product_id", class_name: "Perk"

  validates :name, presence: true
  validates :description, presence: true
  validates :price_cents, presence: true
  validates :category, presence: true


  def purchased_in_the_last_month
     purchases = Purchase.where(verified: true, product_id: self.id)
     purchases.where("created_at >= ?", Date.today - 30)
  end

  def purchased_in_the_last_year
     purchases = Purchase.where(verified: true, product_id: self.id)
     purchases.where("created_at >= ?", Date.today - 365)
  end
end
