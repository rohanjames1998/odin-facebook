require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    it { should define_enum_for(:attachments).with_values [:unavailable, :available] }
    describe "text_content" do
      context "When attachments are available" do
        before do
         allow(subject).to receive(:attachments).and_return [:present]
        end
        it { should_not validate_presence_of(:text_content) }
      end
      context "When attachments are not available" do
        before do
        allow(subject).to receive(:attachments).and_return [:not_present]
        end
        it { should_not validate_presence_of(:text_content) }
      end
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:likes) }
  end

  describe ".relevant_posts" do
    let (:user) { FactoryBot.create(:user) }
    let (:friend) { FactoryBot.create(:user) }
    let (:friend2) { FactoryBot.create(:user) }


    before do
      allow(user).to receive(:friends).and_return([friend, friend2])
    end

    context "When called" do
      it "returns all posts made by users friend" do
        post = FactoryBot.create(:post, user_id: friend.id)
        post2 = FactoryBot.create(:post, user_id: friend2.id )
        posts = Post.relevant_posts(user)
        expect(posts).to include post, post2
      end
    end
  end
end
