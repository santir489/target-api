require 'rails_helper'

describe Message, type: :model do
  describe 'validations' do
    subject { build(:message) }

    it { expect(subject).to validate_presence_of :text }
  end

  describe 'when user is not part of conversation' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let!(:conversation) { create(:conversation, :with_users, user1: user3, user2: user2) }

    subject { build(:message, user: user, conversation: conversation) }

    it 'not to be valid' do
      expect(subject).not_to be_valid
    end

    it 'user not in conversation message' do
      subject.valid?
      expect(subject.errors.messages[:user_in_conversation]).to include(I18n.t('api.errors.users.conversation.belong'))
    end
  end
end
