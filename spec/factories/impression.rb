FactoryBot.define do
  factory :impression do
    served true
    served_at Time.current
    shown false
    clicked false
    ad_unit
    app_session
    interaction_length 500

    trait :shown do
      served_at Time.current - 15.seconds
      shown true
      shown_at Time.current
    end

    trait :clicked do
      served_at Time.current - 15.seconds
      shown true
      shown_at Time.current - 10.seconds
      clicked true
      clicked_at Time.current
    end

  end
end
