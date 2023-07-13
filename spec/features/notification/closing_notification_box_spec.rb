require 'rails_helper'

RSpec.describe "Viewing notifications", type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end
  let(:user) { FactoryBot.create(:user) }

  context "When user clicks anywhere except on the notification box" do
    it "closes the notification box" do
      login(user)
      click_on "notification_btn"
      wait_for_changes
      expect(page).to have_css 'div[data-notifications-target="notificationBox"]'

      click_on "find_friends_btn"

      expect(page).not_to have_css 'div[data-notifications-target="notificationBox"]'
    end
  end
end
