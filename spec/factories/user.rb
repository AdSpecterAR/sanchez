FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { first_name + last_name }
    account_type { [User::ACCOUNT_TYPE_ADVERTISER, User::ACCOUNT_TYPE_DEVELOPER].sample }
    email { Faker::Internet.email }
  end

  trait :developer do
    account_type User::ACCOUNT_TYPE_DEVELOPER
  end

  trait :advertiser do
    account_type User::ACCOUNT_TYPE_ADVERTISER
  end

  trait :new do
    id nil
  end
end
