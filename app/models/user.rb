class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :purchases
  has_many :products, through: :purchases
  has_many :perks, through: :products
  has_one :business


  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :location, presence: true

  def perks
    Perk.where(providing_product_id: self.products.pluck(:id))
  end

  def unverified_purchases
    Purchase.where("verified = false AND user_id = ?", self.id)
  end

  def available_products
    product_ids = self.perks.collect(&:receiving_product_id)
    product_ids.map { |p| Product.find(p) }
  end

  def offering_businesses
    business_ids = self.available_products.collect(&:business_id)
    business_ids.map { |b| Business.find(b) }
  end

end
