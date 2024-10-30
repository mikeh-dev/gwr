require 'rails_helper'

RSpec.describe Agreement, type: :model do
  describe 'associations' do
    it { should belong_to(:property) }
    it { should belong_to(:tenant).class_name('User') }
    it { should delegate_method(:landlord).to(:property) }
  end

  describe 'validations' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:notice_period) }
    it { should validate_presence_of(:monthly_rent_amount) }

    context 'role validations' do
      let(:tenant) { create(:user, role: 'tenant') }
      let(:landlord) { create(:user, role: 'landlord') }
      let(:property) { create(:property, landlord: landlord) }

      it 'is valid with correct roles' do
        agreement = create(:agreement, property: property, landlord: landlord, tenant: tenant)
        expect(agreement).to be_valid
      end

      it 'is invalid with incorrect landlord role' do
        agreement = build(:agreement, property: property, landlord: tenant, tenant: tenant)
        expect(agreement).not_to be_valid
        expect(agreement.errors[:landlord]).to include('must be a landlord')
      end

      it 'is invalid with incorrect tenant role' do
        agreement = build(:agreement, property: property, landlord: landlord, tenant: landlord)
        expect(agreement).not_to be_valid
        expect(agreement.errors[:tenant]).to include('must be a tenant')
      end
    end
  end
end