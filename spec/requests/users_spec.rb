require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "#root" do
    context "If user is signed in" do
      it "redirects to user home page" do
        allow_any_instance_of(Devise::Controllers::Helpers).to receive(:user_signed_in?).and_return true

        get root_path

        expect(response.body).to include("Home")
      end
    end

    context "When user is not signed in" do
      it "redirects to sign up page" do
        allow_any_instance_of(Devise::Controllers::Helpers).to receive(:user_signed_in?).and_return false

        get root_path

        expect(response.body).to include("Sign Up")
      end
    end
  end
end
