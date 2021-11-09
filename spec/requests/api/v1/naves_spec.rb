require 'rails_helper'

RSpec.describe "Requests Naves", :focus, type: :request do
  
  before { host! 'localhost:3000/api/v1' }
  let!(:user) { create(:user) }

  let(:headers) do
    {
      'Content-Type' => Mime[:json].to_s,
      'Accpet' => 'application/vnc.navedex.v1'
    }
  end

  describe 'GET /naves' do
    before do
      create_list(:nave, 25, user: user)
      get '/naves', params: {}, headers: headers
    end

    context 'return successul' do
      it 'status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'naves from the database' do
        expect(json_body[:naves].count).to eq(25)
      end
    end
  end

  describe 'GET /naves/:id' do
    let(:nave) { create(:nave, user: user) }
    before { get "/naves/#{nave.id}", params: {}, headers: headers }

    context "return successful" do
      it 'status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'json for nave' do
        expect(json_body[:name]).to eq(nave.name)
      end
    end
    
  end
end
