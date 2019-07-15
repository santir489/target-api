require 'rails_helper'

describe Message, type: :model do
  describe 'validations' do
    subject { build(:message) }

    it { expect(subject).to validate_presence_of :text }
    it { expect(subject).to validate_presence_of :conversation }
    it { expect(subject).to validate_presence_of :user }
  end
end
