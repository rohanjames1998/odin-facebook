require 'rails_helper'

RSpec.describe "Google OAuth", type: :feature do
  context "When user wants to sign up using Google" do
    it "shows user message that it was successful" do
       visit new_user_registration_path
       click_on "Sign in with GoogleOauth2"
       expect(page).to have_content "Successfully authenticated from Google account."
    end
  end
end
