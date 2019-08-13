class Saving < ApplicationRecord
  belongs_to :perk
  belongs_to :purchase
  belongs_to :user, through: :purchases
end
