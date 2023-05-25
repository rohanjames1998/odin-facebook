require 'rails_helper'

RSpec.describe "Creating a simple text post", type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end
  context "When user creates a valid text post" do
    let(:user)  { FactoryBot.create(:user) }
    let(:quote) { Faker::Quote.famous_last_words }

    it "shows on their home page" do
      login(user)

      fill_in "post_text_content", with: quote
      click_button "Post"

      expect(page).to have_content(quote)
    end

    it "shows on the homepage of their friends" do
      friend = FactoryBot.create(:user)
      FactoryBot.create(:friendship, request_sender_id: user.id, requested_user_id: friend.id)

      login(friend)

      using_session("user") do
        login(user)
        fill_in "post_text_content", with: quote
        click_button "Post"
      end

      expect(page).to have_content(quote)
    end

    it "does not show up on homepage of users who are not poster's friend" do
      random_user = FactoryBot.create(:user)
      login(random_user)
      using_session("user") do
        login(user)
        fill_in "post_text_content", with: quote
        click_button "Post"
      end
      expect(page).not_to have_content(quote)
    end
  end
end
