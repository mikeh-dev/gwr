require 'rails_helper'

RSpec.describe AgreementPolicy, type: :policy do
    let(:admin) { create(:user, role: 'admin') }
    let(:landlord) { create(:user, role: 'landlord') }
    let(:tenant) { create(:user, role: 'tenant') }
    let(:agreement) { create(:agreement, landlord: landlord, tenant: tenant, property: property) }
    let(:property) { create(:property, landlord: landlord) }
  
    subject { described_class.new(user, agreement ) }
  
    context 'as an admin' do
      let(:user) { admin }

        it { is_expected.to permit_actions(%i[create show index update destroy edit]) }
    end
end