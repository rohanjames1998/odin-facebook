require 'rails_helper'

RSpec.describe "Creating post with image", type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless
  end
  let(:user) { FactoryBot.create(:user) }

  context "When user posts an uploaded image" do
    it "shows the image on their home page" do
      login(user)
      wait_for_changes

      click_button "Create Post"
      attach_file('app/assets/images/test_img.png' ) do
        find("#post_images_pictures").click
      end
      wait_for_changes
      click_button 'Post'
      wait_for_changes
      expect(page).to have_css("img[src*='test_img'][src$='.png']")
    end
  end

  context "When user posts multiple images with quotes" do
    let(:quote) { Faker::Quote.famous_last_words }

    it "shows multiple images with quotes on their homepage" do
      login(user)
      wait_for_changes

      click_button "Create Post"
      wait_for_changes
      attach_file(['app/assets/images/test_img.png', 'app/assets/images/test_img_2.png']) do
        find("#post_images_pictures").click
      end
      fill_in "post_text_content", with: quote
      wait_for_changes
      click_button 'Post'
      wait_for_changes
      expect(page).to have_css("img[src*='test_img'][src$='.png']")
      expect(page).to have_css("img[src*='test_img_2'][src$='.png']")
      expect(page).to have_content(quote)
    end
  end
end
