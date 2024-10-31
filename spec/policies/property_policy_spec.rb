require 'rails_helper'

RSpec.describe PropertyPolicy, type: :policy do
    let(:admin) { create(:user, role: 'admin') }
    let(:landlord) { create(:user, role: 'landlord') }
    let(:tenant) { create(:user, role: 'tenant') }
    let(:property) { create(:property, landlord: landlord) }
    let!(:agreement) do
        create(:agreement, 
               landlord: landlord,
               tenant: tenant,
               property: property,
               start_date: Date.today,
               end_date: Date.today + 1.year)
    end

    # Allow the property to find its current agreement
    before do
        allow(property).to receive(:current_agreement).and_return(agreement)
    end

    subject { described_class.new(user, property) }

    context 'as an admin' do
       let(:user) { admin }

        it { is_expected.to permit_actions(%i[create show index update destroy edit]) }
    end

    context 'as a landlord' do
       let(:user) { landlord }

        it { is_expected.to permit_actions(%i[create show index edit update]) }
        it { is_expected.to forbid_actions(%i[destroy]) }
    end

    context 'as a tenant' do
       let(:user) { tenant }

        it { is_expected.to permit_actions(%i[show]) }
        it { is_expected.to forbid_actions(%i[update destroy edit create index]) }
    end

end