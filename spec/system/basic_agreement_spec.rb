require 'rails_helper'

    RSpec.describe "Basic Agreement", type: :system do
        let(:user) { create(:user, role: :landlord) }

        before do
            login_as user
        end
    
        context "when user is signed in as landlord allows them to access agreements index" do        
            visit admin_dashboard_path 
            expect(page).to have_content('Agreements', count: 2)
            
        end
    end
end
