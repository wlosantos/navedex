require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  
  context "attributes must be present" do
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :password }
    it { is_expected.to respond_to :password_confirmation }
  end

  context "associations" do
    it { is_expected.to have_many :naves }
  end
  
  describe 'create' do
    context 'successful' do
      it { expect(user).to be_valid }
    end

    context 'validations' do
      it { is_expected.to validate_presence_of :email }
      it { is_expected.to allow_value('contato@email.com').for(:email) } 
      it { is_expected.to validate_presence_of :password }
      it { is_expected.to validate_confirmation_of :password }
    end
  end

end
