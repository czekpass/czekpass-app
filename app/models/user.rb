class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  mount_uploader :photo, PhotoUploader

  has_many :purchases
  has_many :products, through: :purchases
  has_one :business

  validates :first_name, presence: true
  validates :last_name, presence: true

  def perks(business = nil)
      # Iterate through all the perks available to the user and only include
      # the perk if it's providing_product_id matches the id of a product purchased
      # by the user
    all_perks = Perk.where(purchased_product_id: self.products.pluck(:id))

    if business.nil? == false
      all_perks = business.perks.select do |perk|
        all_perks.include? perk
      end
    end

    all_perks
  end

  def unverified_purchases
    Purchase.where("verified = false AND user_id = ?", self.id)
  end

  def available_products(business = nil)
    if business.nil?
      # if no business is given, get the product id of all perks the user has.
      product_ids = self.perks.collect(&:product_id)
    else
      product_ids = self.perks(business).collect(&:product_id)
    end
    # Do a search with the product id as key. Return array of available products.
    Product.where(id: product_ids)
  end

  def offering_businesses
    # Gets a list of products (with perks) that are available to the user
    business_ids = self.available_products.collect(&:business_id)
    # takes the ids of these products and returns the businesses for the business_ids array.
    Business.where(id: business_ids)
    # Should it be uniq?
  end
end
