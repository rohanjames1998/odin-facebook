FactoryBot.define do

  factory :image do
    picture { Rack::Test::UploadedFile.new('app/assets/images/test_img.png', 'image/png') }
    post nil
    uploader_id { FactoryBot.create(:user).id }
  end
 end
