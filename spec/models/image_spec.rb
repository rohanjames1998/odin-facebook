require 'rails_helper'

RSpec.describe Image, type: :model do

  describe "associations" do
    it { should belong_to(:uploader) }
    it { should belong_to(:post) }
  end

  describe "validations" do
    it { should validate_presence_of(:picture) }
  end
end
