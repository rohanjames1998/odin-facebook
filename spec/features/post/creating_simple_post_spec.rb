require 'rails_helper'

RSpec.describe "Creating a simple text post", type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end
  context "When user creates a valid text post" do
    it "shows on their home page" do
      user = FactoryBot.create(:user)
      quote = Faker::Quote.famous_last_words

      login(user)

      fill_in "post_text_content", with: quote
      click_button "Post"

      expect(page).to have_content(quote)
    end
  end
end
