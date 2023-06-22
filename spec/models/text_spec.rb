require 'rails_helper'

RSpec.describe Text, type: :model do
  describe "associations" do
    it { should belong_to(:author) }
    it { should have_many(:likes) }
  end

  describe "validations" do
    it { should validate_presence_of(:content) }
  end
end
