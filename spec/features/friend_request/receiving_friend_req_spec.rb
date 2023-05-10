require 'rails_helper'

RSpec.describe "Receiving friend request", type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end
  context "When someone receives a friend request" do
    it "shows user option to accept and decline the request" do
      first_user =  FactoryBot.create(:user)
      second_user =  FactoryBot.create(:user)

      login(first_user)
      send_friend_request


      click_on "Log Out"

      wait_for_changes

      login(second_user)
      expect(page).to have_button "Accept"
      expect(page).to have_button "Decline"
    end
  end
end
