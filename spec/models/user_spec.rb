require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build(:user) }
  
  describe "must be present" do
    it { expect(user).to respond_to :email }
    it { expect(user).to respond_to :password }
    it { expect(user).to respond_to :password_confirmation }
  end
  
  describe 'create user' do

    context 'successful' do
      it { expect(user).to be_valid }
    end

    context 'failure' do
      it 'email don\'t be blanck' do
        user.email = ''
        expect(user).not_to be_valid
      end

      it 'password don\'t be blanck' do
        user.password = ''
        expect(user).not_to be_valid
      end
    end
  end

end
