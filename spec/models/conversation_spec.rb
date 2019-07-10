require 'rails_helper'

describe Conversation, type: :model do
  describe 'validations' do
    subject { build(:conversation) }

    it { expect(subject).to have_many(:messages) }
    it { expect(subject).to have_many(:users).through(:conversations_users) }
    it { expect(subject).to have_many(:conversations_users) }
  end

  context '#create_conversation' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    context 'when conversation between users does not exsist' do
      it 'creates a conversation' do
        expect { Conversation.create_conversation(user1, user2) }.to change { Conversation.count }.by(1)
      end
    end

    context 'when conversation between users already exsist' do
      let!(:conversation) { Conversation.create_conversation(user1, user2) }
      it 'does not creates a conversation' do
        expect { Conversation.create_conversation(user2, user1) }.to change { Conversation.count }.by(0)
      end
    end
  end
end
