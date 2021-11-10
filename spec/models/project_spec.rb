require 'rails_helper'

RSpec.describe Project, type: :model do
  
  describe 'attributes must be present' do
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :nave_id }
  end

  describe 'associations' do
    it { is_expected.to belong_to :nave }
  end

  describe 'persist database' do
    context 'successful' do
      let(:nave) { create(:nave) }
      let(:project) { build(:project, nave: nave) }

      it { expect(project).to be_valid }
    end
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :nave_id }
  end
end
