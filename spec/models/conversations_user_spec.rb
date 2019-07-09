require 'rails_helper'

describe ConversationsUser, type: :model do
  describe 'validations' do
    subject { build(:conversations_user) }

    it { expect(subject).to validate_presence_of :conversation }
    it { expect(subject).to validate_presence_of :user }
  end
end
