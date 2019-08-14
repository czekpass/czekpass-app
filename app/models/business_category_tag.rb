class BusinessCategoryTag < ApplicationRecord
  # We're not using this anymore
  belongs_to :business_category
  belongs_to :business
end
