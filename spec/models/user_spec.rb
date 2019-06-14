require 'rails_helper'
describe User, type: :model do

  describe 'validations' do
    subject { build(:user) }

    it { expect(subject).to validate_presence_of :name } 
    it { expect(subject).to validate_presence_of :email }
    it { expect(subject).to validate_presence_of :gender }
    it { expect(subject).to validate_uniqueness_of(:email).case_insensitive.scoped_to(:provider) }
  end  
end
