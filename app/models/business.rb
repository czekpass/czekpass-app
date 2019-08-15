class Business < ApplicationRecord
# Here I'm specifying that our business model has an attribute that will upload something, in this case the business photo.
  mount_uploader :logo, PhotoUploader

  has_many :employees
  has_many :products
  has_many :perk_templates
  # has_many :business_categories, through: :business_category_tags
  belongs_to :user
  belongs_to :business_category

  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true

end
