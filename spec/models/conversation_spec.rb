require 'rails_helper'

describe Conversation, type: :model do
  describe 'validations' do
    subject { build(:conversation) }

    it { expect(subject).to have_many(:messages) }
    it { expect(subject).to have_many(:users).through(:conversations_users) }
    it { expect(subject).to have_many(:conversations_users) }
  end
end
