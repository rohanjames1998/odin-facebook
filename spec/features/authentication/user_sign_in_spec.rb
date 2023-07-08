require 'rails_helper'

RSpec.describe "Sign In", type: :feature do

  context "When user signs in with an existent account" do
    let(:user) { FactoryBot.create(:user) }
    it "redirects to home page" do
      visit "/users/sign_in"

      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password

      click_button "Log in"

      expect(page).to have_content "Home"
    end
  end

  context "When user signs in with unknown account" do
    it "shows an error message" do
      visit "/users/sign_in"

      fill_in "user_email", with: "joe@example.com"
      fill_in "user_password", with: "password"

      click_button "Log in"
      expect(page).to have_content "Invalid Email or password"
    end
  end
end
