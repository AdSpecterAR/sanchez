FactoryGirl.define do
  factory :campaign do
    user
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    click_url { Faker::Internet.url }
    ad_unit_url { Faker::Internet.url }
    active true
  end
end
