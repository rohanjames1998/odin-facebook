require 'rails_helper'

RSpec.describe "Sending friend request", type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end
  # Not using let(:user) because it is lazy loaded and we need to persist some users to our test
  # database in order to assert that friend requests are sent and received
  context "After clicking add friend button" do
    it "changes to cancel request button" do
      first_user =  FactoryBot.create(:user)
      second_user =  FactoryBot.create(:user)

      login(first_user)

      send_friend_request

      expect(page).to have_button "Cancel Request"
    end
  end

  context "If user wants to cancel request they sent using cancel request button" do
    it "deletes the friend request" do
      first_user =  FactoryBot.create(:user)
      second_user =  FactoryBot.create(:user)

      login(first_user)

      send_friend_request
      click_button "Cancel Request"
      wait_for_changes

      expect(second_user.friend_requests).to be_empty
    end
  end
end
