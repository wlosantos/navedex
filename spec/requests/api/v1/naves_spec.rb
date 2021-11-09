require 'rails_helper'

RSpec.describe "Api::V1::Naves", :focus, type: :request do
  
  before { host! 'localhost:3000/api/v1' }
  let!(:user) { create(:user) }

  let(:header) do
    {
      'Content-Type' => Mine[:json].to_s,
      'Accpet' => 'application/vnc.navedex.v1'
    }
  end
end
