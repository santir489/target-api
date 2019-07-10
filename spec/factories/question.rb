FactoryBot.define do
  factory :question do
    message     { Faker::Lorem.question }
    email_from  { Faker::Internet.unique.safe_email }
    email_to    { Faker::Internet.unique.safe_email }
    sent        { Faker::Boolean.boolean }
    user
  end
end
