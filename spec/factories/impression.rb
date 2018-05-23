FactoryBot.define do
  factory :impression do
    served true
    served_at Time.now
    shown false
    clicked false
    ad_unit
    app_session
    interaction_length 0

    trait :shown do
      served_at Time.now - 15.seconds
      shown true
      shown_at Time.now
    end

    trait :clicked do
      served_at Time.now - 15.seconds
      shown true
      shown_at Time.now - 10.seconds
      clicked true
      clicked_at Time.now
    end
  end
end
