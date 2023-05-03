require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe "validations" do
    it { should validate_presence_of(:requested_user_id) }
    it { should validate_presence_of(:request_sender_id) }
    it { should define_enum_for(:status) }
  end

  describe "associations" do
    it { should have_many(:notifications) }
    it { should belong_to(:requested_user) }
    it { should belong_to(:request_sender) }
    it { should accept_nested_attributes_for(:notifications) }
  end
end
