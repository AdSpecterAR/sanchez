FactoryGirl.define do
  factory :impression do
    impression_started_at { Time.now - 20.seconds }
    impression_ended_at { Time.now }
    clicked false
    campaign
    developer_app
  end
end
