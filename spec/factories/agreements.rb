FactoryBot.define do
  factory :agreement do
    agreement_number { '1234' }
    length { 12 }
    notice_period { 30 }
    monthly_rent_amount { 1000.00 }
    association :property
    association :tenant, factory: :user

    transient do
      overlap_buffer { 1.day } # Buffer to avoid overlap
    end

    after(:build) do |agreement, evaluator|
      last_agreement = agreement.property.agreements.order(end_date: :desc).first

      if last_agreement
        agreement.start_date = last_agreement.end_date + evaluator.overlap_buffer
        agreement.end_date = agreement.start_date + agreement.length.months
      else
        agreement.start_date = Date.today
        agreement.end_date = Date.today + agreement.length.months
      end
    end
  end
end