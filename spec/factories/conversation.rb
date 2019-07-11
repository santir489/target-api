FactoryBot.define do
  factory :conversation do
    factory :convarsation_with_users do
      transient do
        user1 { create(:user) }
        user2 { create(:user) }
      end

      after(:create) do |conversation, evaluator|
        conversation.users << evaluator.user1
        conversation.users << evaluator.user2
      end
    end

    factory :convarsation_with_users_and_messages do
      transient do
        user1 { create(:user) }
        user2 { create(:user) }
        user1_messages_count { 5 }
        user2_messages_count { 5 }
      end

      after(:create) do |conversation, evaluator|
        conversation.users << evaluator.user1
        conversation.users << evaluator.user2

        create_list(:message, evaluator.user1_messages_count, user: evaluator.user1, conversation: conversation)
        create_list(:message, evaluator.user2_messages_count, user: evaluator.user2, conversation: conversation)
      end
    end
  end
end
