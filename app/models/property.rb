class Property < ApplicationRecord
  belongs_to :landlord, class_name: 'User', foreign_key: 'owner_id'

  validates :title, :address, :postcode, :city, :property_type, presence: true

  enum property_type: { house: 0, apartment: 1, commercial: 2, land: 3}
end
