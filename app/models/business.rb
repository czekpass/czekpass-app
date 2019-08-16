class Business < ApplicationRecord
  mount_uploader :logo, PhotoUploader

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_many :employees
  has_many :products
  has_many :perks
  has_many :perk_templates

  belongs_to :user
  belongs_to :business_category

  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true

end
