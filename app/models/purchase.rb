class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :perks, through: :product

  # validates :expiration_date, presence: true
  # validates :verified, inclusion: { in: [true, false] }

  def expiration_date
    # self.created_at + rand(15..35).days.from_now
  end

  def business_id
    self.product.business_id
  end
end
