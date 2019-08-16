class Saving < ApplicationRecord
  belongs_to :perk
  belongs_to :purchase
  has_one :user, through: :purchase

  validates :amount, presence: true
  validates :kind, presence: true
end
