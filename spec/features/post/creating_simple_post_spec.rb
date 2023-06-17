require 'rails_helper'

RSpec.describe "Creating post", type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end
  context "When user creates a valid text post" do
    let(:user)  { FactoryBot.create(:user) }
    let(:quote) { Faker::Quote.famous_last_words }

    it "shows on their home page" do
      login(user)

      click_button "Create Post"
      fill_in "post_text_content", with: quote
      click_button "Post"
      wait_for_changes

      expect(page).to have_content(quote)
    end
  end
end
