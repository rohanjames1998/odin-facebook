require 'rails_helper'

RSpec.describe "Updating user profile", type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless

    Bullet.enable = false
  end

  context "When user updates their profile data" do
    let(:user) { FactoryBot.create(:user, :with_profile) }
    let(:bio) { Faker::Quote.famous_last_words }
    let(:date) { Faker::Date.in_date_period(year: 1998, month: 6) }
    it "shows the new data on user show page" do
      sign_in(user)
      visit user_path(user)
      wait_for_changes

      click_on "Edit profile"
      attach_file('app/assets/images/test_img.png') do
        find("#profile_avatar_picture").click
      end

      attach_file('app/assets/images/test_img_2.png') do
        find("#profile_cover_picture").click
      end

      fill_in "profile_bio", with: bio

      fill_in "profile_country", with: "India"

      fill_in "profile_city", with: "Delhi"

      fill_in "profile_date_of_birth", with: date

      click_on "Save Profile"

      expect(page).to have_css("img[src*='test_img'][src$='.png']")
      expect(page).to have_css("img[src*='test_img_2'][src$='.png']")
      expect(page).to have_content(bio)
      expect(page).to have_content(date)
      expect(page).to have_content("India")
      expect(page).to have_content("Delhi")
    end
  end
end
