FactoryBot.define do
  factory :property do
    title { 'Sample Property' }
    address { '123 Main Street' }
    postcode { '12345' }
    city { 'Sample City' }
    property_type { :house }
    notes { 'Sample notes' }
  end
end
