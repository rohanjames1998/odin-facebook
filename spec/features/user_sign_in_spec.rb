RSpec.describe "Sign In", type: :feature do

  context "When user signs in with an existent account" do
    let(:user) { FactoryBot.create(:user) }
    it "redirects to home page" do
      visit "/users/sign_in"

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"

      expect(page).to have_content "Home"
    end
  end

  context "When user signs in with unknown account" do
    it "shows an error message" do
      visit "/users/sign_in"

      fill_in "Email", with: "joe@example.com"
      fill_in "Password", with: "password"

      click_button "Log in"
      expect(page).to have_content "Invalid Email or password"
    end
  end
end
