require 'rails_helper'

RSpec.describe "A user submits a link" do
  context "it is valid", js: true do
    it "shows the link on the user's index" do
      sign_in FactoryGirl.create(:user)

      visit '/links'
      fill_in "title", with: 'Example'
      fill_in "url", with: 'http://www.example.com'
      click_on 'Submit Link'

      expect(current_path).to eq('/links')
      within('.link') do
        expect(page).to have_content('Example')
        expect(page).to have_content('http://www.example.com')
      end
    end

    it "does not show the link on another user's index", js: true do
      user_1 = FactoryGirl.create(:user, email: 'a@gmail.com')
      user_2 = FactoryGirl.create(:user, email: 'b@gmail.com')
      sign_in user_2
      FactoryGirl.create(:link, user_id: user_1, title: 'Example')

      visit '/'

      expect(page).not_to have_content('Example')
    end
  end
  
  context "it is not valid" do
    it "returns an error message", js: true do
      sign_in FactoryGirl.create(:user)

      visit '/links'
      fill_in "title", with: 'Example'
      fill_in "url", with: 'WHEEOOWHEEOOWHEEOO' 
      click_on 'Submit Link' 

      expect(page).to have_content "Must be a valid URL"
      expect(page).not_to have_content('Example')
    end
  end
end
