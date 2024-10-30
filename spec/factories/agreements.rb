FactoryBot.define do
  factory :agreement do
    agreement_number { '1234' }
    length { 12 }
    notice_period { 30 }
    monthly_rent_amount { 1000.00 }
    association :property
    association :tenant, factory: :user

    trait :current do
      start_date { Date.today }
      end_date { Date.today + 12.months }
    end

    trait :expired  do
      start_date { Date.today - 12.months }
      end_date { Date.today - 1.month }
    end
  end
end