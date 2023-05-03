require 'rails_helper'

RSpec.describe "Friend Request", type: :feature do
  # Not using let(:user) because it is lazy loaded and we need to persist some users to our test
  # database in order to assert that friend requests are sent and received
  context "after clicking add friend buton" do
    it "it changes to cancel request button" do
      first_user =  FactoryBot.create(:user)
      second_user =  FactoryBot.create(:user)

      login(first_user)

      send_friend_request

      expect(page).to have_button "Cancel Request"
    end
  end

  context "When someone sends a friend request" do
    xit "shows user option to accept and decline the request" do
      first_user =  FactoryBot.create(:user)
      second_user =  FactoryBot.create(:user)

      login(first_user)

      send_friend_request
      click_on "Log Out"

      login(second_user)

      expect(page).to have_button "Accept"
      expect(page).to have_button "Decline"
    end
  end

  context "When user accepts the friend request" do
    xit "adds both user in their friends list" do
      first_user =  FactoryBot.create(:user)
      second_user =  FactoryBot.create(:user)
      first_user_name = "#{first_user.first_name} #{first_user.last_name}"
      second_user_name = "#{second_user.first_name} #{second_user.last_name}"
      first_user_profile_link = user_path(first_user)
      second_user_profile_link = user_path(second_user)

      login(first_user)

      send_friend_request
      click_on "Log Out"

      login(second_user)

      click_on "My Friends"

      expect(page).to have_link first_user_name, href: first_user_profile_link

      click_on "Log Out"

      login(first_user)

      click_on "My Friends"

      expect(page).to have_link second_user_name, href: second_user_profile_link
    end
  end

  def login(user)
    # This method logs in as given user and goes to home page.
    sign_in user
    visit user_home_path(user)
  end

  def send_friend_request
    click_on "Find Friends"
    click_button "Add Friend"
  end
end
