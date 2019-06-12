require 'rails_helper'


RSpec.describe Target, type: :model do
 
  let(:target) { build(:target) }

  describe 'validations' do
    it { expect(target).to validate_presence_of :title } 
    it { expect(target).to validate_presence_of :length }
    it { expect(target).to validate_presence_of :longitude }
    it { expect(target).to validate_presence_of :latitude }
    it { expect(target).to validate_presence_of :topic }
    it { expect(target).to validate_uniqueness_of(:title).case_insensitive }
  end


end

