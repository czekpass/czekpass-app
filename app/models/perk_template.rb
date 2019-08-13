class PerkTemplate < ApplicationRecord
  belongs_to :business
  belongs_to :receiving_product
end
