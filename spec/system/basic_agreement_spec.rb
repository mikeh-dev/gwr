require 'rails_helper'

    RSpec.describe "Basic Agreement", type: :system do
        let(:tenant) { create(:user, role: :tenant) }
        let(:admin) { create(:user, role: :admin) }
        let(:landlord) { create(:user, role: :landlord) }
        let(:landlord2) { create(:user, role: :landlord) }
        let(:property) { create(:property, title: 'Old Title', landlord: landlord) }
        let(:property2) { create(:property, title: 'New Title', landlord: landlord2) }
        let(:agreement1) { create(:agreement, :current, tenant: tenant, property: property, agreement_number: "1234") }
        let(:agreement2) { create(:agreement, :expired, tenant: tenant, property: property2, agreement_number: "5678") }
    
        context "when user is signed in as landlord" do

            before do
                login_as landlord
                agreement1
                agreement2
            end

            it "allows them to access agreements index" do
                visit admin_dashboard_path
                expect(page).to have_content('Agreements', count: 3)
                within('#main-summary') do
                    click_link 'Agreements'
                end
                expect(page).to have_content('Agreements')
                expect(page).to have_content('Create Agreement')
            end

            it "only allows them to view their own agreements in index" do
                visit admin_dashboard_path
                within('#main-summary') do
                    click_link 'Agreements'
                end
                expect(page).to have_content("Agreements")
                expect(page).to have_content(agreement1.agreement_number)
                expect(page).to have_no_content(agreement2.agreement_number)
            end

            it "only allows them to view his own agreement show view" do
                visit agreement_path(agreement1)
                expect(page).to have_content(agreement1.agreement_number)
                visit agreement_path(agreement2)
                expect(page).to have_content('You are not authorized to access this page.')
            end


            it "allows them to create a new agreement" do
                visit admin_dashboard_path
                within('#main-summary') do
                    click_link 'Agreements'
                end
                click_link 'Create Agreement'
                expect(page).to have_content('New Agreement')

                select property.title, from: 'Property'
                select tenant.full_name, from: 'Tenant'

                fill_in 'Length', with: 12
                fill_in 'Start Date', with: Date.today
                fill_in 'End Date', with: Date.today + 1.year
                fill_in 'Notice Period', with: 3
                fill_in 'Monthly Rent Amount', with: 1000
                fill_in 'Agreement Number', with: '1234'
                click_button 'Save Agreement'
                expect(page).to have_content('Agreement was successfully created.')
            end

            it "allows them to view an agreement" do
                visit agreement_path(agreement1)
                expect(page).to have_content('Agreement')
                expect(page).to have_content(agreement1.length)
                expect(page).to have_content(agreement1.start_date)
                expect(page).to have_content(agreement1.end_date)
                expect(page).to have_content(agreement1.notice_period)
                expect(page).to have_content(agreement1.monthly_rent_amount)
            end

            it "allows them to edit an agreement" do
                visit edit_agreement_path(agreement1)
                expect(page).to have_content('Edit Agreement')
            end

            it "does not allow them to delete an agreement" do
                visit admin_dashboard_path
                within('#main-summary') do
                    click_link 'Agreements'
                end
                expect(page).to have_no_link('Delete')
            end
        end

        context "when user is signed in as admin" do
            before do
                login_as admin
                agreement1
                agreement2
            end

            it "allows them to access agreements index" do
                visit agreements_path
                expect(page).to have_content('Agreements')
                expect(page).to have_content('Create Agreement')
            end

            it "allows them to view all agreements in index" do
                visit admin_dashboard_path
                expect(page).to have_content("Agreements")
                expect(page).to have_content(agreement1.agreement_number)
                expect(page).to have_content(agreement2.agreement_number)
            end

            it "allows them to view any agreement show view" do
                visit agreement_path(agreement1)
                expect(page).to have_content(agreement1.agreement_number)
                visit agreement_path(agreement2)
                expect(page).to have_content(agreement2.agreement_number)
            end

            it "allows them to create a new agreement" do
                visit admin_dashboard_path
                click_link 'Create Agreement'
                expect(page).to have_content('New Agreement')

                expect(page).to have_select('Property', with_options: ['Old Title'])

                select property.title, from: 'Property'
                select tenant.full_name, from: 'Tenant'
                

                fill_in 'Length', with: 12
                fill_in 'Start Date', with: Date.today
                fill_in 'End Date', with: Date.today + 1.year
                fill_in 'Notice Period', with: 3
                fill_in 'Monthly Rent Amount', with: 1000
                fill_in 'Agreement Number', with: '1234'
                click_button 'Save Agreement'
                expect(page).to have_content('Agreement was successfully created.')
            end
        end
    end