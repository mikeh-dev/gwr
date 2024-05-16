class Agreement < ApplicationRecord
  belongs_to :property
  belongs_to :landlord, class_name: 'User'
  belongs_to :tenant, class_name: 'User'

  validates :length, :start_date, :end_date, :notice_period, :monthly_rent_amount, presence: true
  validate :validate_roles

  private

  def validate_roles
    errors.add(:landlord, 'must be a landlord') unless landlord&.landlord?
    errors.add(:tenant, 'must be a tenant') unless tenant&.tenant?
  end
end

