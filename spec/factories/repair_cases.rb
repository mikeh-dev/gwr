FactoryBot.define do
    factory :repair_case do
        title { 'Sample Repair Case' }
        details { 'Sample details' }
        association :agreement
        status { 0 }
    end
end
