require 'rails_helper'

RSpec.describe "A user submits a link" do
  context "it is valid" do
    it "shows the link on the user's index" do
      sign_in FactoryGirl.create(:user)

      visit '/links'
      fill_in "link_title", with: 'Example'
      fill_in "link_url", with: 'www.example.com'
      click_on 'Submit Link'

      expect(current_path).to eq('/links')
      within('.link:first') do
        expect(page).to have_content('Example')
        expect(page).to have_content('www.example.com')
      end
    end

    it "does not show the link on another user's index" do
      user_1 = FactoryGirl.create(:user, email: 'a@gmail.com')
      user_2 = FactoryGirl.create(:user, email: 'b@gmail.com')
      sign_in user_2
      FactoryGirl.create(:link, user: user_1, title: 'Example')

      visit '/'

      expect(page).not_to have_content('Example')
    end
  end
  
  context "it is not valid" do
    it "returns an error message" do
    end
  end
end
