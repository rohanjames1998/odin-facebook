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

  describe "#add_likes_to_associated_models" do
  let(:post) { FactoryBot.create(:post) }
  let(:img_1) { FactoryBot.create(:image) }
  let(:img_2) { FactoryBot.create(:image) }
  let(:text) { FactoryBot.create(:text) }
  let(:comment) { FactoryBot.create(:comment)}

  before do
    helper.request.session[:current_user_id] =
    FactoryBot.create(:user).id
  end
    context "When given post model" do
      it "add likes to all associated images" do
        post.images << img_1
        post.images << img_2
        helper.add_likes_to_associated_models("Post", post.id)
        expect(img_1.likes.count).to eq 1
        expect(img_2.likes.count).to eq 1
      end

      it "add likes to associated text" do
        post.text = text
        helper.add_likes_to_associated_models("Post", post.id)
        expect(post.text.likes.count).to eq 1
      end
    end

    context "When given comment model" do
      it "add likes to associated text" do
        helper.add_likes_to_associated_models("Comment", comment.id)
        expect(comment.text.likes.count).to eq 1
      end
    end
  end
end
