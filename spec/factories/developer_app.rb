FactoryBot.define do
  factory :developer_app do
    user
    name { Faker::Lorem.word }
    download_link { Faker::Internet.url }
    platform { DeveloperApp::VALID_PLATFORMS.sample }
  end
end
