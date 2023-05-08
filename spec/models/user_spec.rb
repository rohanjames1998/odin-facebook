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

end
