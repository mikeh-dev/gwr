require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:properties).with_foreign_key('owner_id').class_name('Property') }
    it { should have_many(:agreements_as_landlord).class_name('Agreement').with_foreign_key('landlord_id') }
    it { should have_many(:agreements_as_tenant).class_name('Agreement').with_foreign_key('tenant_id') }
    it { should have_one_attached(:avatar) }
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values([:tenant, :landlord, :admin]) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:role) }
    it { should define_enum_for(:role).with_values([:tenant, :landlord, :admin]) }

    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
  end

  describe 'callbacks' do
    it 'downcases the email before saving' do
      user = User.new(email: 'TEST@EXAMPLE.COM')
      user.save
      expect(user.email).to eq('test@example.com')
    end
  end

  describe 'methods' do
    it 'returns the full name' do
      user = User.new(first_name: 'John', last_name: 'Doe')
      expect(user.full_name).to eq('John Doe')
    end
  end
end