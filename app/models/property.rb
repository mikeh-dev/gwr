class Property < ApplicationRecord
  belongs_to :landlord, class_name: 'User', foreign_key: 'owner_id'
  has_many :agreements

  validates :title, :address, :postcode, :city, :property_type, presence: true

  enum property_type: { house: 0, apartment: 1, commercial: 2, land: 3}

  def display_name
    "#{title} - #{address}"
  end

  def current_agreement
    agreements.where('start_date <= ? AND end_date >= ?', Date.today, Date.today).first
  end
end