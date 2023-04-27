require 'rails_helper'

RSpec.describe "Friend Request", type: :feature do

  let(:first_user) { FactoryBot.create(:user) }
  let(:second_user) { FactoryBot.create(:user) }

  context "After sending a friend request" do
    it "shows tells user that it was successful" do
      login_as(first_user)

      click_on "Find Friends"
      click_button "Add Friend"

      expect(page).to have_content "Sent Successfully!"
    end
  end

  context "When someone sends a friend request" do
    xit "shows user option to accept and decline the request" do
      login_as(first_user)

      click_on "Find Friends"
      click_button "Add Friend"
      click_on "Log Out"

      login_as(second_user)

      expect(page).to have_button "Accept"
      expect(page).to have_button "Decline"
    end
  end

  context "When user accepts the friend request" do
    xit "adds both user in their friends list" do
      first_user_name = "#{first_user.first_name} #{first_user.last_name}"
      second_user_name = "#{second_user.first_name} #{second_user.last_name}"
      first_user_profile_link = user_path(first_user)
      second_user_profile_link = user_path(second_user)

      login_as(first_user)

      send_friend_request
      click_on "Log Out"

      login_as(second_user)

      click_on "My Friends"

      expect(page).to have_link first_user_name, href: first_user_profile_link

      click_on "Log Out"

      login_as(first_user)

      click_on "My Friends"

      expect(page).to have_link second_user_name, href: second_user_profile_link
    end
  end
end
