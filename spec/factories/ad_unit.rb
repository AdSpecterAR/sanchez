FactoryBot.define do
  factory :ad_unit do
    user
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    click_url { Faker::Internet.url }
    ad_unit_url { Faker::Internet.url }
    dimensions { AdUnit::DIMENSIONS_16_BY_9 }
    ad_format { AdUnit::FORMAT_VIDEO }
    last_served_at nil
    active true
    video_length 0

    trait :rewarded do
      rewarded true
    end

    trait :interstitial do
      interstitial true
    end

  end
end
