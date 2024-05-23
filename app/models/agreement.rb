class Agreement < ApplicationRecord
  belongs_to :property
  belongs_to :landlord, class_name: 'User'
  belongs_to :tenant, class_name: 'User'

  validates :length, :start_date, :end_date, :notice_period, :monthly_rent_amount, :property_id, :landlord_id, :tenant_id, :agreement_number, presence: true
  validate :validate_roles

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

  
end

