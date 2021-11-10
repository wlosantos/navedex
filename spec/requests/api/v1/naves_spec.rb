require 'rails_helper'

RSpec.describe "Requests Naves", :focus, type: :request do
  
  before { host! 'localhost:3000/api/v1' }
  let!(:user) { create(:user) }
  let!(:auth_data) { user.create_new_auth_token }

  let(:headers) do
    {
      'Content-Type': Mime[:json].to_s,
      'Accpet': 'application/vnc.navedex.v1',
      'access-token': auth_data['access-token'],
      'uid': auth_data['uid'],
      'client': auth_data['client']
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

  describe 'POST /naves' do
    let(:nave) { create(:nave, user: user) }
    before { post '/naves', params: nave_params.to_json, headers: headers }

    context 'return successful' do
      let(:nave_params) { attributes_for(:nave) }
      it 'status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'return failure' do
      let(:nave_params) { attributes_for(:nave, name: '')}
      it 'status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /naves/:id' do
    let(:nave) { create(:nave, user: user) }
    before { put "/naves/#{nave.id}", params: nave_params.to_json, headers: headers }

    context 'return successful' do
      let(:nave_params) { {job_role: 'Desenvolvedor Jr'} }

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'json data for the nave' do
        expect(json_body[:name]).to eq(nave.name)
      end
    end

    context 'return failure' do
      let(:nave_params) { {name: ''} }

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'return message errors' do
        expect(json_body[:errors][0]).to include("can't be blank")
      end
    end
  end

  describe 'DELETE /naves/:id' do
    let(:nave) { create(:nave, user: user) }
    before { delete "/naves/#{nave.id}", params: {}, headers: headers }

    context 'successful - delete nave' do
      it 'return status code 204' do
        expect(response).to have_http_status(204)
      end
    end

  end 
end
