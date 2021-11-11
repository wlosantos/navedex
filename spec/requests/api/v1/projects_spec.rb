require 'rails_helper'

RSpec.describe "Request Projects", :focus, type: :request do

  before { host! 'localhost:3000/api/v1' }
  let!(:user) { create(:user) }
  let!(:nave) { create(:nave, user: user) }
  let!(:nave_id) { nave.id }
  let!(:auth_data) { user.create_new_auth_token }
  let(:headers) do
    {
      'Accept': 'application/vnd.navedex.v1',
      'Content-Type': Mime[:json].to_s,
      'access-token': auth_data['access-token'],
      'uid': auth_data['uid'],
      'client': auth_data['client']
    }
  end

  describe 'GET /projects' do
    let(:user2) { create(:user) }
    let(:nave2) { create(:nave, user: user2) }
    before do
      create_list(:project, 10, nave: nave)
      create_list(:project, 15, nave: nave2)
      get "/projects", params: paramsUser.to_json, headers: headers
    end

    context 'return list' do
      let(:paramsUser) { {currentUser: user.id} }
      it 'successful' do
        expect(response).to have_http_status(:ok)
      end

      it 'database projects user' do
        expect(json_body.count).to eq(10)
      end
    end
  end

  # describe 'GET /projects' do
  #   before do
  #     create_list(:project, 10, nave: nave)
  #     get "/naves/#{nave_id}/projects", params: {}, headers: headers
  #   end

  #   context 'successful - return list' do
  #     it 'status code 200' do
  #       expect(response).to have_http_status(200)
  #     end

  #     it 'database projects' do
  #       expect(json_body.count).to eq(10)
  #     end
  #   end
  # end

  # describe 'GET /projects/:id' do
  #   let(:project) { create(:project, nave: nave) }
  #   before { get "/naves/#{nave_id}/projects/#{project.id}", params: {}, headers: headers }

  #   context 'return sucessful' do
  #     it 'status code 200' do
  #       expect(response).to have_http_status(200)
  #     end

  #     it 'json for project' do
  #       expect(json_body[:name]).to eq(project.name)
  #     end
  #   end
  # end

  # describe 'POST /projects' do
  #   let(:project) { create(:project, nave: nave) }
  #   before { post "/naves/#{nave_id}/projects", params: project_params.to_json, headers: headers }

  #   context 'return successful' do
  #     let(:project_params) { attributes_for(:project) }
  #     it 'status code 201' do
  #       expect(response).to have_http_status(:created)
  #     end
  #   end

  #   context 'return failure' do
  #     let(:project_params) { attributes_for(:project, name: '') }
  #     it 'status code 422' do
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #     it 'errors messages' do
  #       expect(json_body[:errors][0]).to include('can\'t be blank')
  #     end
  #   end
  # end

  # describe 'PUT /projects/:id' do
  #   let(:project) { create(:project, nave: nave) }
  #   before do
  #     put "/naves/#{nave_id}/projects/#{project.id}",
  #     params: project_params.to_json,
  #     headers: headers
  #   end

  #   context 'return successful' do
  #     let(:project_params) { { name: 'Desenvolvimento de apps' } }

  #     it 'return status code 200' do
  #       expect(response).to have_http_status(:ok)
  #     end
  #   end

  #   context 'return failure' do
  #     let(:project_params) { {name: ''} }

  #     it 'return status code 422' do
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #   end
  # end

  # describe 'DELETE /projects/:id' do
  #   let(:project) { create(:project, nave: nave) }
  #   before do
  #     delete "/naves/#{nave_id}/projects/#{project.id}",
  #     params: {},
  #     headers: headers
  #   end

  #   context 'successful - delete project' do
  #     it 'return status code 200' do
  #       expect(response).to have_http_status(:ok)
  #     end
  #   end
  # end

end
