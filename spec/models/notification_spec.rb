require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "associations" do
    it { should belong_to(:receiver) }
    it { should belong_to(:sender) }
    it { should belong_to(:notifiable) }
  end

  describe "validations" do
    it { should validate_presence_of(:receiver_id) }
    it { should validate_presence_of(:sender_id) }
  end
end
