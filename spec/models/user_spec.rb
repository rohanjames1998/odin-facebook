require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }
  end

  describe "associations" do
    it { should have_many(:notifications) }
    it { should have_many(:sent_notifications) }
    it { should have_many(:friend_requests) }
    it { should have_many(:friend_requests_sent) }
    it { should have_many(:friends_i_added) }
    it { should have_many(:friends_that_added_me) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe "#name" do
    context "When called" do
      it "returns the full name of the user" do
        user = FactoryBot.create(:user)
        full_name = user.name
        expect(full_name).to include user.first_name
        expect(full_name).to include user.last_name
      end
    end
  end

  describe "#friends" do
    context "When called" do
      it "returns all of the user's friends" do
        first_user = FactoryBot.create(:user)
        second_user = FactoryBot.create(:user)
        third_user = FactoryBot.create(:user)

        Friendship.create(requested_user_id: second_user.id, request_sender_id: first_user.id, status: :accepted)
        Friendship.create(requested_user_id: first_user.id, request_sender_id: third_user.id, status: :accepted)

        friends = first_user.friends

        expect(friends).to include second_user, third_user
      end
    end
  end

end
