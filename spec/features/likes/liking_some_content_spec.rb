require 'rails_helper'

RSpec.describe "Liking a post", type: :feature, js: true do

  before do
    Capybara.current_driver = :selenium_chrome_headless
  end

  context "When user likes a post" do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }

    before do
      allow(Post).to receive(:relevant_posts).and_return([post])
    end

    it "shows user that the post was liked" do
      login(user)

      click_button "Like"

      expect(page).to have_content "1 Like"
    end
  end
end
