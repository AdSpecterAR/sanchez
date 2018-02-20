FactoryBot.define do
  factory :impression do
    impression_started_at { Time.now - 20.seconds }
    impression_ended_at { Time.now }
    clicked false
    ad_unit
    developer_app
  end
end
