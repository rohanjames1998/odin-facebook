require 'rails_helper'

RSpec.describe "Commenting on a post", type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end

  context "When user comments on a post" do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }
    let(:quote) { Faker::Quote.famous_last_words }

    before do
      allow(Post).to receive(:relevant_posts).and_return([post])
      # disabling bullet gem because it is wrongly presenting errors.
      Bullet.enable = false
    end
    it "shows their comment on the post" do
      login(user)

      click_button "Comment"
      fill_in "comment_text_content", with: quote
      click_button "Post Comment"

      within "#comments" do
        expect(page).to have_content(quote)
      end
    end
  end
end
