require 'rails_helper'

RSpec.describe "When user comments on a post", type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end

  context "and someone has that post's dialog opened on their screen" do
    let(:user) { FactoryBot.create(:user) }
    let(:quote) { Faker::Quote.famous_last_words }
    let(:watching_user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }

    before do
      allow(Post).to receive(:relevant_posts).and_return([post])
      # disabling bullet gem because it is wrongly presenting errors.
      Bullet.enable = false
    end
    it "shows the comment on the screen of watching user" do
      login(watching_user)
      wait_for_changes
      click_on "Comment" #This opens up the post's dialog.

      using_session("user") do
        login(user)
        wait_for_changes
        click_button "Comment"
        within "dialog" do
          fill_in "comment_text_content", with: quote
          click_button "Post Comment"
        end
      end
      within "#comments" do
        expect(page).to have_content(quote)
      end
    end
  end
end
