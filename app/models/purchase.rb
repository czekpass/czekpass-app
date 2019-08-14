class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :expiration_date, presence: true
  # This helper validates that the attributes' values are included in a given set.
  # https://guides.rubyonrails.org/active_record_validations.html#inclusion
  validates :verified, inclusion: { in: [true, false] }
end
