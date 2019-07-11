FactoryBot.define do
  factory :conversations_user do
    user
    conversation
    unread_messages 0
  end
end
