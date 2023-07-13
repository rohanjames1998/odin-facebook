require 'rails_helper'

RSpec.describe "Viewing notifications", type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end
  let(:user) { FactoryBot.create(:user) }

  context "When user clicks the bell icon" do
    it "shows user the notification box" do
      login(user)
      click_on "notification_btn"
      expect(page).to have_css 'div[data-notifications-target="notificationBox"]'
    end
  end
end
