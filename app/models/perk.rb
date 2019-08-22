class Perk < ApplicationRecord
  belongs_to :patronized_business, class_name: "Business"
  belongs_to :purchased_product, class_name: "Product"
  belongs_to :product
  belongs_to :business

  validates :description, presence: true
  validates :kind, presence: true
  validates :amount, presence: true

  after_create :discounted_price_calculation

  def discounted_price_calculation
    if kind == 'percentage' && !product.nil?
      product_price = product.price # Either purchased_product OR product
      self.discounted_price = product_price * amount / 100
      save
    elsif kind == "amount" && !product.nil?
      product_price = product.price
      self.discounted_price = product_price - amount
      save
    end
  end
end
