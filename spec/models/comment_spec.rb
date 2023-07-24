require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "associations" do
    it { should belong_to(:post) }
    it { should belong_to(:author).class_name("User") }
    it { should have_many(:likes) }
    it { should have_many(:notifications) }
    it { should have_one(:text) }
    it { should accept_nested_attributes_for(:text) }
    it do
      should belong_to(:parent_comment).
        class_name("Comment").optional
    end
    it do
      should have_many(:replies).with_foreign_key("parent_comment_id").class_name("Comment")
    end
  end

  describe "validations" do
    it { should validate_presence_of(:text) }
  end

  describe "#is_a_reply?" do
    context "when comment is a reply" do
      it "returns true" do
        comment = FactoryBot.create(:comment, :reply)
        output = comment.is_a_reply?
        expect(output).to be true
      end
    end
    context "when comment is not a reply" do
      it "returns false" do
        comment = FactoryBot.create(:comment)
        output = comment.is_a_reply?
        expect(output).to be false
      end
    end
  end
end
