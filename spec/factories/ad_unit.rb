FactoryBot.define do
  factory :ad_unit do
    user
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    click_url_default { Faker::Internet.url }
    ad_unit_url { Faker::Internet.url }
    aspect_ratio_width { 16 }
    aspect_ratio_height { 9 }
    ad_format { AdUnit::FORMAT_VIDEO }
    last_served_at nil
    active true
    video_length 1000
    call_to_action 'no button'

    trait :rewarded do
      rewarded true
    end

    trait :interstitial do
      interstitial true
    end

    trait :wide do
      aspect_ratio_width { 16 }
      aspect_ratio_height { 9 }
    end
  end
end
