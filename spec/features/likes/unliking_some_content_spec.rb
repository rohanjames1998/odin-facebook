require 'rails_helper'
# Content here stands for either post or comment.
RSpec.describe "Unliking some content", type: :feature,
js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
    allow(Post).to receive(:relevant_posts).and_return([post])
  end

  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }

  context "After liking some content" do
    it "shows the unlike button" do
      login(user)

      click_button "Like"

      expect(page).to have_button "Unlike"
    end
  end
  context "Clicking the unlike button" do
    it "decreases the like count" do
      login(user)

      click_button "Like"

      wait_for_changes

      click_button "Unlike"
      wait_for_changes

      expect(post.likes.count).to eq(0)
    end
  end
end
