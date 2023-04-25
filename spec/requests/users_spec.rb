require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "#root" do
  let(:user) { FactoryBot.create(:user) }
    context "If user is signed in" do
      it "redirects to user's home page" do
        allow_any_instance_of(Devise::Controllers::Helpers).to receive(:user_signed_in?).and_return true
        allow_any_instance_of(Devise::Controllers::Helpers).to receive(:current_user).and_return(user)

        get root_path

        expect(response).to redirect_to(user_home_path(user))
      end
    end

    context "When user is not signed in" do
      it "redirects to sign up page" do
        allow_any_instance_of(Devise::Controllers::Helpers).to receive(:user_signed_in?).and_return false

        get root_path

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
