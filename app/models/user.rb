class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :purchases
  has_many :products, through: :purchases
  # This won't work as it the association is too deep.
  # has_many :perks, through: :products
  has_one :business


  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :location, presence: true

  def all_perks
    Perk.where(purchased_product_id: self.products.pluck(:id))
  end

  def perks(business)
      # Iterate through all the perks available to the user and only include
      # the perk if it's providing_product_id matches the id of a product purchased
      # by the user
    business.perks.select do |perk|
      all_perks.include? perk
     end
  end

  def unverified_purchases
    Purchase.where("verified = false AND user_id = ?", self.id)
  end

  def available_products(business = nil)
    if business.nil?
      product_ids = self.all_perks.collect(&:product_id)
    else
      product_ids = self.perks(business).collect(&:product_id)
    end
    product_ids.map { |p| Product.find(p) }
  end

  def offering_businesses
    business_ids = self.available_products.collect(&:business_id)
    business_ids.map { |b| Business.find(b) }
  end
end
