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
    before do
      create_list(:project, 10, nave: nave)
      get "/naves/#{nave_id}/projects", params: {id: nave_id}, headers: headers
    end

    context 'successful - return list' do
      it 'status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'database projects' do
        expect(json_body[:projects].count).to eq(10)
      end
    end
  end

end
