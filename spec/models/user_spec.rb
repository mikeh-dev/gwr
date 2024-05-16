require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:properties).with_foreign_key('owner_id').class_name('Property') }
    it { should have_one_attached(:avatar) }
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values([:tenant, :landlord, :admin]) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
  end
end