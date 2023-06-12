require 'rails_helper'
RSpec.describe LikesHelper, type: :helper do
  describe "#already_liked?" do
    # Content here can be either post or comment.
    context "When user has already like the content" do
      it "returns true" do
        like = FactoryBot.create(:like)
        request.session[:current_user_id] = like.user.id
        expect(helper.already_liked?(like.likeable_type, like.likeable_id)).to eq(true)
      end
    end
    context "If the use hasn't liked the content before" do
      it "returns false" do
        # Because we are not persisting the like to database it should return false
        new_like = FactoryBot.build(:like)
        request.session[:current_user_id] = new_like.user.id
        expect(helper.already_liked?(new_like.likeable_type, new_like.likeable_id)).to eq(false)
      end
    end
  end
end
