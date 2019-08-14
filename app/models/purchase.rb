class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :product
  # validates :expiration_date, presence: true
  # validates :verified, inclusion: { in: [true, false] }
end
