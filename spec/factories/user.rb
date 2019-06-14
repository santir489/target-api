FactoryBot.define do
  factory :user do
    email     { Faker::Internet.safe_email }
    password  { Faker::Internet.password(10, 20) }
  end
end
