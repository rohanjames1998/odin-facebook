FactoryBot.define do

  factory :image do
    picture { Rack::Test::UploadedFile.new('app/assets/images/test_img.png', 'image/png') }
    uploader_id { FactoryBot.create(:user).id }
    imageable_id { FactoryBot.create(:post).id }
    imageable_type { "Post" }
  end
 end
