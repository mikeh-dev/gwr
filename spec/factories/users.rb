FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    role { :tenant }

    trait :tenant do
      role { :tenant }
    end

    trait :landlord do
      role { :landlord }
    end

    trait :admin do
      role { :admin }
    end
  end
end