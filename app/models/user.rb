class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :purchases
  has_many :products, through: :purchases
  has_many :perks, through: :products
  has_many :businesses


  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :location, presence: true

  def all_perks
    Perk.where(providing_product_id: self.products.pluck(:id))
  end

  def perks(businesses)
    #perks = Perk.where(receiving_product_id: businesses)
    # businesses[0].perks

    # A business has many perks thorugh products
    # business.perks.select do |perk|
    #   # Iterate through all the perks available to the user and only include
    #   # the perk if it's providing_product_id matches the id of a product purchased
    #   # by the user
    #   all_perks.include? perk.providing_product_id
    # end
  end

  def unverified_purchases
    Purchase.where("verified = false AND user_id = ?", self.id)
  end

  def available_products
    product_ids = self.all_perks.collect(&:receiving_product_id)
    product_ids.map { |p| Product.find(p) }
  end

  def offering_businesses
    business_ids = self.available_products.collect(&:business_id)
    business_ids.map { |b| Business.find(b) }
  end
end
