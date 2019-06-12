FactoryBot.define do
  

  sequence :email do |n|
    "person#{n}@gmail.com"
  end

  sequence :titulo do |n|
    "Titulo#{n}"
  end

  factory :target do
    title {generate(:titulo)}
    length 234
    topic "football"
    longitude 3.0
    latitude 6.0
    association :user, factory: :user
  end


  factory :user do
    email {generate(:email) }
    password "123456"
  end


end