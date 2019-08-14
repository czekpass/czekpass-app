class BusinessCategory < ApplicationRecord
  # We're not using this anymore 'has_many :business_category_tags'
  belongs_to :business
  validates :name, presence: true
end
