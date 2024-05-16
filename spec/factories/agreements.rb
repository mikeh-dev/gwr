FactoryBot.define do
  factory :agreement do
    length { 12 }
    start_date { Date.today }
    end_date { Date.today + 1.year }
    notice_period { 30 }
    monthly_rent_amount { 1000.00 }
    association :property
    association :landlord, factory: [:user, :landlord]
    association :tenant, factory: [:user, :tenant]
  end
end