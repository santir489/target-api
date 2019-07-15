FactoryBot.define do
  factory :conversation do
    factory :convarsation_with_users do
      transient do
        user1 { create(:user) }
        user2 { create(:user) }
      end

      before(:create) do |conversation, evaluator|
        conversation.users << evaluator.user1
        conversation.users << evaluator.user2
      end
    end

    factory :convarsation_with_users_and_messages do
      transient do
        user1 { create(:user) }
        user2 { create(:user) }
        user1_messages_count { 5 }
        user1_unread_messages_count { 5 }
        user2_messages_count { 5 }
        user2_unread_messages_count { 5 }
      end

      before(:create) do |conversation, evaluator|
        conversation.users << evaluator.user1
        conversation.users << evaluator.user2

        create_list(:message, evaluator.user1_messages_count, user: evaluator.user1, conversation: conversation)
        create_list(:message, evaluator.user2_messages_count, user: evaluator.user2, conversation: conversation)

        conversation.conversations_users.find_by(user_id: evaluator.user1)
                    .update(unread_messages: evaluator.user1_unread_messages_count)
        conversation.conversations_users.find_by(user_id: evaluator.user2)
                    .update(unread_messages: evaluator.user2_unread_messages_count)
      end
    end
  end
end
