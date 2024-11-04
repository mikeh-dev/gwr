require 'rails_helper'

RSpec.describe 'RepairCase', type: :system do
    let(:admin) { create(:admin) }
    let(:tenant) { create(:tenant) }
    let(:landlord) { create(:landlord) }
    let(:property) { create(:property) }
    let(:agreement) { create(:agreement, :current, tenant: tenant, property: property, landlord: landlord, agreement_number: "1234") }
    let(:repair_case) { create(:repair_case, agreement: agreement) }

    context 'when a user is signed in as a admin' do
        before do
            login_as admin
        end

        it 'allows admin to create a repair case' do
            visit new_repair_case_path
            expect(page).to have_content("New Repair Case")
            select agreement.property.title, from: "Repair case[agreement_id]"
            fill_in "Title", with: "Sample Repair Case"
            fill_in "Details", with: "Sample details"
            click_button "Create Repair case"
            expect(page).to have_content("Repair case was successfully created.")
            expect(page).to have_content("Sample Repair Case")
            expect(page).to have_content("Sample details")
            expect(page).to have_content(agreement.property.title)
            expect(page).to have_content("Open")
        end

        it 'allows the admin to view all repair cases' do
            visit repair_cases_path
            expect(page).to have_content(repair_case.title)
            expect(page).to have_content(repair_case.status)
            expect(page).to have_content(repair_case.agreement.property.title)
            expect(page).to have_content(repair_case.agreement.tenant.full_name)
            expect(page).to have_content(repair_case.agreement.landlord.full_name)
            expect(page).to have_content(repair_case.agreement.agreement_number)
            expect(page).to have_content(repair_case.created_at.strftime("%d/%m/%Y"))
            expect(page).to have_content(repair_case.updated_at.strftime("%d/%m/%Y"))
            expect(page).to have_content("View Repair Case")
        end

        it 'allows the admin to view any open repair cases' do
            visit repair_cases_path(repair_case)
            expect(page).to have_content(repair_case.title)
            expect(page).to have_content(repair_case.status)
        end

        it 'allows admin to edit a repair case' do
            visit edit_repair_case_path(repair_case)
            expect(page).to have_content("Edit Repair Case")
            fill_in "Title", with: "Updated Title"
            click_button "Update Repair Case"
            expect(page).to have_content("Repair case was successfully updated.")
        end

        it 'allows admin to delete a repair case' do
            visit repair_case_path(repair_case)
            click_link "Delete Repair Case"
            expect(page).to have_content("Repair case was successfully deleted.")
        end

        it 'allows admin to resolve a repair case' do
            visit repair_case_path(repair_case)
            click_link "Resolve Repair Case"
            expect(repair_case.status).to eq("resolved")
            expect(page).to have_content("Repair case was successfully resolved.")
        end
    end

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