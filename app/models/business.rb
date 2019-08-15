class Business < ApplicationRecord
  has_many :employees
  has_many :products
  has_many :perks
  has_many :perk_templates

  has_many :business_categories, through: :business_category_tags

  belongs_to :user
  belongs_to :business_category

  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true
end
