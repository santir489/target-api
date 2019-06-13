FactoryBot.define do
  factory :target do
    sequence(:title) { |n| "#{Faker::Lorem.word}_#{n}" }
    length           { Faker::Number.between(1, 12000) }
    topic            Target.topics.keys.sample
    longitude        { Faker::Number.decimal(2).to_f }
    latitude         { Faker::Number.decimal(2).to_f }
    user
  end
end
