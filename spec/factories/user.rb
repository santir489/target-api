FactoryBot.define do
  factory :user do
    email     { Faker::Internet.unique.safe_email }
    password  { Faker::Internet.password(10, 20) }
    name      { Faker::Internet.unique.username }
    gender    User.genders.keys.sample
  end
end
