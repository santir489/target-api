require 'rails_helper'

describe Conversation, type: :model do
  describe 'associations' do
    subject { build(:conversation) }

    it { expect(subject).to have_many(:messages) }
    it { expect(subject).to have_many(:users).through(:conversations_users) }
    it { expect(subject).to have_many(:conversations_users) }
  end

  context 'validate uniqueness between users' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    let!(:conversation) { create(:convarsation_with_users, user1: user1, user2: user2) }
    subject { create(:convarsation_with_users, user1: user2, user2: user1) }

    it 'not to be valid' do
      expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
