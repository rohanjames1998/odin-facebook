RSpec.describe "Friend Request", type: :feature do

  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }

  context "After sending a friend request" do
    it "shows tells user that it was successful" do
      login_as(user1)

      click_on "Find Friends"
      click_button "Add Friend"

      expect(page).to have_content "Sent Successfully!"
    end
  end

  context "When someone sends a friend request" do
    xit "shows user option to accept and decline the request" do
      login_as(user1)

      click_on "Find Friends"
      click_button "Add Friend"
      click_on "Log Out"

      login_as(user2)

      expect(page).to have_button "Accept"
      expect(page).to have_button "Decline"
    end
  end

  context "When user accepts the friend request" do
    xit "adds both user in their friends list" do
      user1_name = "#{user1.first_name} #{user1.last_name}"
      user2_name = "#{user2.first_name} #{user2.last_name}"
      user1_profile_link = user_path(user1)
      user2_profile_link = user_path(user2)

      login_as(user1)

      send_friend_request
      click_on "Log Out"

      login_as(user2)

      click_on "My Friends"

      expect(page).to have_link user1_name, href: user1_profile_link

      click_on "Log Out"

      login_as(user1)

      click_on "My Friends"

      expect(page).to have_link user2_name, href: user2_profile_link
    end
  end
end
