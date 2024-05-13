class Property < ApplicationRecord
  belongs_to :landlord, class_name: 'User', foreign_key: 'owner_id'

  validates :title, :address, :postcode, :city, :property_type, presence: true
end
