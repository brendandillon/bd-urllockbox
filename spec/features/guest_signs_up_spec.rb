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
      User.create(email: 'b@gmail.com', password: 'pass', password_confirmation: 'pass')

      visit '/'
      click_on 'Sign Up'
      fill_in 'user_email', with: 'b@gmail.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_on 'Sign up'

      expect(flash[:alert]).to eq('A user with this email already exists.')
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

      expect(flash[:alert]).to eq('The password and confirmation do not match.')
    end
  end
end
