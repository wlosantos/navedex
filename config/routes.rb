require 'api_version_constraint'

Rails.application.routes.draw do
  
  namespace :api, defaults: { format: :json } do 
    mount_devise_token_auth_for 'User', at: 'auth'
    
    namespace :v1, constraints: ApiVersionConstraint.new(version: 1, default: true) do
      resources :naves, only: %i[ index show create update destroy ]
    end
  end
end
