class Agreement < ApplicationRecord
  belongs_to :property
  belongs_to :landlord, class_name: 'User'
  belongs_to :tenant, class_name: 'User' 
  has_many_attached :move_in_images

  validates :property, :tenant, :start_date, :end_date, :notice_period, :monthly_rent_amount, presence: true
  validate :validate_roles

  after_save :set_landlord, :set_renewal_date

  scope :current, -> { where('end_date >= ?', Date.today) }
  scope :expired, -> { where('end_date < ?', Date.today) }
  scope :upcoming_renewals, -> { current.where('renewal_date <= ?', Date.today + 90.days) }

  private

  def set_renewal_date
    self.renewal_date = end_date - notice_period.days if end_date.present?
  end
 
  def set_landlord
    self.landlord_id = property.owner_id
  end

  def validate_roles
    errors.add(:landlord, 'must be a landlord') unless landlord&.landlord?
    errors.add(:tenant, 'must be a tenant') unless tenant&.tenant?
  end

  def not_overlapping_dates_for_same_property
    overlapping_agreements = property.agreements.where.not(id: id)
      .where('start_date < ? AND end_date > ?', end_date, start_date)
    
    if overlapping_agreements.exists?
      errors.add(:base, 'Agreement dates overlap with another agreement for the same property')
    end
  end
end