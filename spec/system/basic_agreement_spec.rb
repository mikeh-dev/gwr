require 'rails_helper'

    RSpec.describe "Basic Agreement", type: :system do
        let(:user) { create(:user, role: :landlord) }

        before do
            login_as user
        end
    
        context "when user is signed in as landlord" do
            it "allows them to access agreements index" do
                visit admin_dashboard_path
                expect(page).to have_content('Agreements', count: 2)
                within('#main-summary') do
                    click_link 'Agreements'
                end
                expect(page).to have_content('Agreements')
                expect(page).to have_content('Create Agreement')
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
        end
    end