require 'rails_helper'

RSpec.describe "Users - requests", type: :request do
  let!(:user) { create(:user) }
  let!(:user_id) { user.id }
  let!(:auth_data) { user.create_new_auth_token }
  let(:headers) do
    {
      'Accept': 'application/json',
      'Content-Type': Mime[:json].to_s,
      'access-token': auth_data['access_token'],
      'uid': auth_data['uid'],
      'client': auth_data['client']
    }
  end
  before { host! 'localhost:3000/api' }

  describe 'SIGN OUT /auth' do
    before { post '/auth', params: user_params.to_json, headers: headers }

    context 'successful - create user is valid' do
      let(:user_params) { attributes_for(:user) }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'return json data create user' do
        expect(json_body[:data][:email]).to eq(user_params[:email])
      end
    end

    context 'failure - ivalid create user' do
      let(:user_params) { attributes_for(:user, email: '') }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'the data for the errors' do
        expect(json_body).to have_key(:errors)
      end
    end
  end

  describe 'SIGN IN /auth/sign_n' do
    before { post '/auth/sign_in', params: user_params.to_json, headers: headers }

    context 'successful - login valid' do
      let(:user_params) { {email: user.email, password: user.password} }

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'return token user' do
        expect(response.headers['access_token']).to eq(headers['access_token'])
      end
    end

    context 'failure - login invalid' do
      let(:user_params) { {email: '', password: ''} }

      it 'return status code 401' do
        expect(response).to have_http_status(401)
      end

      it 'return message errors' do
        expect(json_body[:errors][0]).to eq('Invalid login credentials. Please try again.')
      end
    end
  end

  # describe 'VALIDATE TOKEN /auth/validate_token' do
  #   before { get '/auth/validate_token', params: {}, headers: headers }

  #   context 'successful - token is valid' do
  #     it 'return status code 200' do
  #       expect(response).to have_http_status(200)
  #     end
  #   end
  # end

  # describe 'SIGN OUT /auth/sign_out' do
  #   before { delete '/auth/sign_out', params: {}, headers: headers }

  #   context 'successfull - delete user' do
  #     it 'return status code 204' do
  #       expect(response).to have_http_status(204)
  #     end
  #   end
  # end

  # describe 'UPDATE /auth' do
  #   before { put '/auth', params: user_params.to_json, headers: headers }

  #   context 'successful - update valid' do
  #     let(:user_params) { {password: '654321'} }

  #     it 'return status code 200' do
  #       expect(response).to have_http_status(200)
  #     end

  #     it 'return data for the updated' do
  #       expect(json_body[:data][:email]).to eq(user_params[:email])
  #     end
  #   end
  # end
end
