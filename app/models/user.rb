class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :purchases
  has_many :products, through: :purchases
  has_many :perks, through: :products
  has_one :business


  def perks
    Perk.where(providing_product_id: self.products.pluck(:id))
  end

end
