require 'rails_helper'

RSpec.describe "A user logs in" do
  it "takes them to the links page" do
    User.create(email: 'b@gmail.com', password: 'password', password_confirmation: 'password')

    visit '/'
    click_on 'Log in'
    fill_in 'user_email', with: 'b@gmail.com'
    fill_in 'user_password', with: 'password'
    click_on 'Log in'

    expect(current_path).to eq('/links')
  end
end
