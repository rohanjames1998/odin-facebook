require 'rails_helper'

RSpec.describe "When user creates a post", type: :feature, js: true do

  before do
    Capybara.current_driver = :selenium_chrome_headless
  end

  context "and they have friends online" do
    let(:user)  { FactoryBot.create(:user) }
    let(:quote) { Faker::Quote.famous_last_words }

    it "shows on the homepage of their friends" do
      friend = FactoryBot.create(:user)
      FactoryBot.create(:friendship, request_sender_id: user.id, requested_user_id: friend.id)

      login(friend)

      using_session("user") do
        wait_for_changes
        login(user)
        wait_for_changes
        click_button "Create Post"
        fill_in "post_text_content", with: quote
        click_button "Post"
      end

      expect(page).to have_content(quote)
    end
  end
end
