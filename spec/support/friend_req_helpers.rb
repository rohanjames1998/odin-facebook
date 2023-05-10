module FriendReqHelpers

  def login(user)
    # This method logs in as given user and goes to home page.
    sign_in user
    visit user_home_path user
  end

  def send_friend_request
    click_on "Find Friends"
    click_button "Add Friend"
  end
end

