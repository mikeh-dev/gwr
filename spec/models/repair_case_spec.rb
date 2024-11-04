require 'rails_helper'

RSpec.describe RepairCase, type: :model do
  describe 'associations' do
    it { should belong_to(:agreement) }
  end
end