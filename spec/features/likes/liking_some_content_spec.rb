require 'rails_helper'

# Content here stands for either post or comment.
RSpec.describe "Liking some content", type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end

  context "When user likes some content" do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }

    before do
      allow(Post).to receive(:relevant_posts).and_return([post])
    end

    it "shows user that the content was liked" do
      login(user)

      click_button "Like"

      expect(page).to have_content "1 Like"
    end

    it "increases the contents's like count" do
      login(user)

      click_button "Like"
      wait_for_changes

      expect(post.likes.count).to eq(1)
    end
  end
end
