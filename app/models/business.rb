class Business < ApplicationRecord
  has_many :employees
  has_many :products
  has_many :perk_templates
  # Nope, this is changed 'has_many :business_categories, through: :business_category_tags'
  has_many :business_categories
  belongs_to :user

  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true
end