class Property < ApplicationRecord
  belongs_to :landlord, class_name: 'User', foreign_key: 'owner_id'
  has_many_attached :property_images
  
  # Base association with scopes
  has_many :agreements
  has_one :current_agreement, -> { 
    where('start_date <= ? AND end_date >= ?', Date.today, Date.today)
  }, class_name: 'Agreement'

  has_many :past_agreements, -> { 
    where('end_date < ?', Date.today)
  }, class_name: 'Agreement'

  has_many :future_agreements, -> { 
    where('start_date > ?', Date.today)
  }, class_name: 'Agreement'

  validates :title, :address, :postcode, :city, :property_type, presence: true

  enum property_type: { house: 0, apartment: 1, commercial: 2, land: 3}

  def display_name
    "#{title} - #{address}"
  end

  def current_tenant
    current_agreement&.tenant
  end

  def past_tenants
    past_agreements.map(&:tenant).uniq
  end
end