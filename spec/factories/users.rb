FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }

    factory :tenant do
      role { :tenant }
    end

    factory :landlord do
      role { :landlord }
    end

    factory :admin do
      role { :admin }
    end
  end
end