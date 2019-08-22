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

  def top_partner

  end

  def activated_perks
    perks = self.perks
    results = []
    perks.each do |perk|
      info = {}
      total_activations = 0
      total_price = 0
      connected_purchase = Purchase.where(product_id: perk.product_id)
      count = connected_purchase.count
      info[:description] = perk.description
      info[:count] = count
      connected_purchase.each do |connected|
        total_activations += 1 if connected.verified?
        total_price += (self.price_cents / 100) - perk.discounted_price if connected.verified?
        # total_price = total_price - perk.discounted_price
      end
      info[:total_activations] = total_activations
      info[:total_price] = total_price
      results << info
     end
     results
    end
end




