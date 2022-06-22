FactoryBot.define do
  factory :error_log do
    row { Faker::Number.positive.to_i }
    message { Faker::Lorem.paragraph }
    import
  end
end
