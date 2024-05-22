require 'rails_helper'

    RSpec.describe "Basic Agreement", type: :system do
        let(:landlord) { create(:user, role: :landlord) }
        let(:agreement1) { create(:agreement, landlord: landlord) }
        let(:agreement2) { create(:agreement, landlord: another_landlord) }
        let(:property) { create(:property) }
        let(:tenant) { create(:user, role: :tenant) }
        let(:another_landlord) { create(:user, role: :landlord) }
    
        context "when user is signed in as landlord" do

            before do
                login_as landlord
            end

            it "allows them to access agreements index" do
                visit admin_dashboard_path
                expect(page).to have_content('Agreements', count: 2)
                within('#main-summary') do
                    click_link 'Agreements'
                end
                expect(page).to have_content('Agreements')
                expect(page).to have_content('Create Agreement')
            end

            it "only allows them to view their own agreements" do
                visit admin_dashboard_path
                within('#main-summary') do
                    click_link 'Agreements'
                end
                expect(page).to have_content(agreement1.length)
                expect(page).to have_no_content(agreement2.length)
            end

            it "allows them to create a new agreement" do
                visit admin_dashboard_path
                within('#main-summary') do
                    click_link 'Agreements'
                end
                click_link 'Create Agreement'
                expect(page).to have_content('New Agreement')
                fill_in 'Length', with: 12
                fill_in 'Start date', with: Date.today
                fill_in 'End date', with: Date.today + 1.year
                fill_in 'Notice period', with: 3
                fill_in 'Monthly rent amount', with: 1000
                click_button 'Create Agreement'
                expect(page).to have_content('Agreement was successfully created.')
            end

            it "allows them to view an agreement" do
                agreement = create(:agreement)
                visit admin_dashboard_path
                within('#main-summary') do
                    click_link 'Agreements'
                end
                click_link 'Show'
                expect(page).to have_content('Agreement')
                expect(page).to have_content(agreement.length)
                expect(page).to have_content(agreement.start_date)
                expect(page).to have_content(agreement.end_date)
                expect(page).to have_content(agreement.notice_period)
                expect(page).to have_content(agreement.monthly_rent_amount)
            end

            it "allows them to edit an agreement" do
                agreement = create(:agreement)
                visit admin_dashboard_path
                within('#main-summary') do
                    click_link 'Agreements'
                end
                click_link 'Edit'
                expect(page).to have_content('Edit Agreement')
                fill_in 'Length', with: 12
                fill_in 'Start date', with: Date.today
                fill_in 'End date', with: Date.today + 1.year
                fill_in 'Notice period', with: 3
                fill_in 'Monthly rent amount', with: 1000
                click_button 'Update Agreement'
                expect(page).to have_content('Agreement was successfully updated.')
            end

            it "does not allow them to delete an agreement" do
                agreement = create(:agreement)
                visit admin_dashboard_path
                within('#main-summary') do
                    click_link 'Agreements'
                end
                expect(page).to have_no_link('Delete')
            end
        end
    end