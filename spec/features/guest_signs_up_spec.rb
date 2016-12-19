require 'rails_helper'

RSpec.describe "A guest signs up" do
  context "they enter proper information" do
    it "logs in the user" do
      visit '/'
      click_on 'Sign Up'
      fill_in 'user_email', with: 'b@gmail.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_on 'Sign up'

      expect(current_path).to eq('/links')
    end
  end

  context "they sign up with an email address that has already been used" do
    it "returns an error message" do
      FactoryGirl.create(:user, email: 'b@gmail.com')

      visit '/'
      click_on 'Sign Up'
      fill_in 'user_email', with: 'b@gmail.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_on 'Sign up'

      expect(page).to have_content('Email has already been taken')
    end
  end

  context "password and confirmation do not match" do
    it "returns an error message" do
      visit '/'
      click_on 'Sign Up'
      fill_in 'user_email', with: 'b@gmail.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'punks_not_dead'
      click_on 'Sign up'

      expect(page).to have_content("Password confirmation doesn't match")
    end
  end
end
