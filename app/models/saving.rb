class Saving < ApplicationRecord
  belongs_to :perk
  belongs_to :purchase
  belongs_to :user, through: :purchases

  validates :amount, presence: true
  validates :kind, presence: true
end
