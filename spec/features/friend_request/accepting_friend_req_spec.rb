require 'rails_helper'

RSpec.describe "Accepting friend request", type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end
  context "When user accepts the friend request" do
    it "adds both user in their friends list" do
      first_user =  FactoryBot.create(:user)
      second_user =  FactoryBot.create(:user)
      first_user_name = "#{first_user.first_name} #{first_user.last_name}"
      second_user_name = "#{second_user.first_name} #{second_user.last_name}"
      first_user_profile_link = users_path(first_user)
      second_user_profile_link = users_path(second_user)

      login(first_user)

      send_friend_request
      click_on "Log Out"

      wait_for_changes

      login(second_user)

      click_button "Accept"
      click_on "My Friends"

      expect(page).to have_link first_user_name, href: user_path(first_user)

      click_on "Log Out"

      wait_for_changes

      login(first_user)

      click_on "My Friends"

      expect(page).to have_link second_user_name, href: user_path(second_user)
    end
  end
end
