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
  end
end
