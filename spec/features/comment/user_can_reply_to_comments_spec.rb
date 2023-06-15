require 'rails_helper'

RSpec.describe "Replying to a comment", type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end

  context "When user replies to a comment" do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }
    let(:quote) { Faker::Quote.famous_last_words }
    let(:comment) { FactoryBot.create(:comment, post_id: post.id)}

    before do
      allow(Post).to receive(:relevant_posts).and_return([post])
      # disabling bullet gem because it is wrongly presenting errors.
      Bullet.enable = false
    end
    it "shows their reply under the comment" do
      comment.post = post
      login(user)
      click_button "Comment"
      within "#comment_#{comment.id}" do
        click_button "Reply"
        fill_in "comment_text_content", with: quote
        click_button "Post Comment"
        wait_for_changes
      end
      expect(page).to have_content quote
    end
  end
end
