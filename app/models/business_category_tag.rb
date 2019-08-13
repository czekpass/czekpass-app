class BusinessCategoryTag < ApplicationRecord
  belongs_to :business_category
  belongs_to :business
end
