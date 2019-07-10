require 'rails_helper'

describe Question, type: :model do
  describe 'validations' do
    subject { build(:question) }

    it { expect(subject).to validate_presence_of :message }
    it { expect(subject).to validate_presence_of :email_from }
    it { expect(subject).not_to allow_value('invalid_email').for(:email_from) }
  end
end
