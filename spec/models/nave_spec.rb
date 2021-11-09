require 'rails_helper'

RSpec.describe Nave, type: :model do
  let(:nave) { build(:nave) }

  context "attributes must be present" do
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :birthdate }
    it { is_expected.to respond_to :admision_job }
    it { is_expected.to respond_to :job_role }
    it { is_expected.to respond_to :user_id }
  end

  context "associations" do
    it { is_expected.to belong_to :user }
  end
  

  describe 'create' do
    context "successful" do
      let(:user) { create(:user) }
      let(:nave) { build(:nave, user: user) }
      it { expect(nave).to be_valid }
    end
    
    context 'validations' do
      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_presence_of :birthdate }
      it { is_expected.to validate_presence_of :admision_job }
      it { is_expected.to validate_presence_of :job_role }
      it { is_expected.to validate_presence_of :user_id }
    end
    
  end
end
