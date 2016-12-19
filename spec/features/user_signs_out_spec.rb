require 'rails_helper'

RSpec.describe "A user signs out" do
  it "redirects back to the root" do
    sign_in FactoryGirl.create(:user)

    visit '/links'

    expect(page).not_to have_link('Sign in')
    click_on 'Sign out'

    expect(page).to have_link('Sign in')
  end
end
