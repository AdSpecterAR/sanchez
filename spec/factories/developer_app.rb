FactoryBot.define do
  factory :developer_app do
    user
    name { Faker::Lorem.word }
  end
end
