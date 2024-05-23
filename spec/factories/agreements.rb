FactoryBot.define do
  factory :agreement do
    agreement_number { '1234'}
    length { 12 }
    start_date { Date.today }
    end_date { Date.today + 1.year }
    notice_period { 30 }
    monthly_rent_amount { 1000.00 }
    property
    landlord { property.landlord }
    tenant { create(:user, :tenant) }
  end
end