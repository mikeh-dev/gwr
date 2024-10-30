class Agreement < ApplicationRecord
  belongs_to :property
  delegate :landlord, to: :property
  belongs_to :tenant, class_name: 'User' 

  validates :property, :tenant, :start_date, :end_date, :notice_period, :monthly_rent_amount, presence: true

  validate :validate_roles

  has_many_attached :move_in_images

  def formatted_start_date
    start_date.strftime("%d/%m/%y") if start_date.present?
  end

  def formatted_end_date
    end_date.strftime("%d/%m/%y") if end_date.present?
  end

  def renewal_date
    end_date - notice_period.days if end_date.present?
  end

  def formatted_renewal_date
    renewal_date.strftime("%d/%m/%y") if renewal_date.present?
  end

  private

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
