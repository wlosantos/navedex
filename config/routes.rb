require 'api_version_constraint'

Rails.application.routes.draw do
  
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, defaults: { format: :json } do 
    namespace :v1, constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :naves, only: %i[ index show ]
    end
  end
end
