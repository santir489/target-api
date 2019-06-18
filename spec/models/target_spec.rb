require 'rails_helper'

describe Target, type: :model do
  describe 'validations' do
    subject { build(:target) }

    it { expect(subject).to validate_presence_of :title } 
    it { expect(subject).to validate_presence_of :length }
    it { expect(subject).to validate_presence_of :longitude }
    it { expect(subject).to validate_presence_of :latitude }
    it { expect(subject).to validate_presence_of :topic }
    it { expect(subject).to validate_uniqueness_of(:title).case_insensitive }
  end

  describe 'when user reaches maximum targets' do
    let(:user) { create(:user) }
    let!(:targets) do
      create_list(:target, 10, user: user)
    end

    subject { build(:target, user: user.reload) } 
    
    it 'not to be valid' do        
      expect(subject).not_to be_valid
    end    

    it 'maximum target message' do
      subject.valid?
      expect(subject.errors.messages[:target_maximum]).to include(I18n.t('api.errors.maximum_reached'))
    end   
  end
end
