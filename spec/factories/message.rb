FactoryBot.define do
  factory :message do
    text         { Faker::Lorem.sentence(1, true, 6) }
    conversation { create(:conversation, :with_users, user1: user) }
    user
  end
end
