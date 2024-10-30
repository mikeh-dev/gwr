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

  describe 'enums' do
    it 'should define enum for property_type' do
      should define_enum_for(:property_type).
        with_values({ house: 0, apartment: 1, commercial: 2, land: 3 })
    end
  end
end