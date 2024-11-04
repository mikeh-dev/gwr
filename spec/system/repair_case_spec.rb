require 'rails_helper'

RSpec.describe 'RepairCase', type: :system do
    let(:user) { create(:user) }
    let(:tenant) { create(:tenant) }
    let(:landlord) { create(:landlord) }
    let(:property) { create(:property) }
    let(:agreement) { create(:agreement, :current, tenant: tenant, property: property, landlord: landlord, agreement_number: "1234") }
    let(:repair_case) { create(:repair_case, agreement: agreement) }

    context 'when a user is signed in as a tenant and they have an active agreement' do
        before do
            login_as tenant
        end

        it 'allows the tenant to create a repair case' do
            
        end

        it 'allows the tenant to view a repair case' do
            visit repair_case_path(repair_case)
            expect(page).to have_content(repair_case.title)
            expect(page).to have_content(repair_case.details)
            expect(page).to have_content(repair_case.agreement.property.title)
        end

    end
end