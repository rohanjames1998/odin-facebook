require 'rails_helper'

RSpec.describe "Likes", type: :request do
  describe "#create" do
    #content can be either post or comment.
    context "If user has previously liked the content" do
      let(:like) { FactoryBot.create(:like)}
      it "responds with 403" do

        post likes_path, params: { like: { user_id: like.user_id, likeable_type: like.likeable_type, likeable_id: like.likeable_id }}

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
