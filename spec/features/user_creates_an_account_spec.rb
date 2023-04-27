require 'rails_helper'

RSpec.describe "Sign Up", type: :feature do

    let(:user)  { FactoryBot.build(:user) }

  context "When signing up with valid credentials" do
    it "redirects to home page" do
      visit "/users/sign_up"

      fill_in "First name", with: user.first_name
      fill_in "Last name", with: user.last_name
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      fill_in "Password confirmation", with: user.password

      click_button 'Sign up'

      expect(page).to have_content 'Home'
    end
  end

  context "When signing up with invalid credentials" do
    it "shows an error message" do
      visit "/users/sign_up"

      fill_in "First name", with: user.first_name
      fill_in "Last name", with: user.last_name
      fill_in "Email", with: ""
      fill_in "Password", with: ""
      fill_in "Password confirmation", with: ""

      click_button "Sign up"

      expect(page).to have_selector "div#error_explanation"
    end
  end
end
