# FILEPATH: /Users/michaelhoward/Portfolio/gwr/spec/models/property_spec.rb

require 'rails_helper'

RSpec.describe Property, type: :model do
  describe 'associations' do
    it { should belong_to(:landlord).class_name('User').with_foreign_key('owner_id') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:postcode) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:property_type) }
  end

  
end