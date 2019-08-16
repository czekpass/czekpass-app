class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :perks, through: :product

  # validates :expiration_date, presence: true
  # validates :verified, inclusion: { in: [true, false] }
end
