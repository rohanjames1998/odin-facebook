require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe "associations" do
    it { should have_one(:avatar).class_name("Image").conditions(sub_type: "profile_avatar") }
    it { should have_one(:cover).class_name("Image").conditions(sub_type: "profile_cover") }
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_length_of(:bio).is_at_most(500) }
  end
end
