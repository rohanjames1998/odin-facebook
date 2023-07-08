require 'rails_helper'

RSpec.describe "Github OAuth", type: :feature do
  context "When user wants to sign up using Github" do
    it "shows user message that it was successful" do
       visit new_user_registration_path
       click_on "Continue With GitHub"
       expect(page).to have_content "Successfully authenticated from Github account."
    end
  end
end
