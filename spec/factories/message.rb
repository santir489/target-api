FactoryBot.define do
  factory :message do
    text { Faker::Lorem.sentence(1, true, 6) }
    conversation
    user
  end
end
