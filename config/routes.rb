Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # post 'user_token' => 'user_token#create'

  ### AUTHENTICATION ###

  resources :sessions, only: [:create, :destroy]

  ### USERS ###

  post "/users" => "users#create"
  get "/users" => "users#index"

  ### IMPRESSIONS ###

  resources :impressions, except: [:show, :delete]

  ### AD UNITS ###

  get "/ad_units/default" => "ad_units#default"
  post "/ad_units" => "ad_units#create"

  ### DEVELOPER APPS ###

  get "/developer_app" => "developer_apps#show"
  post "/developer_app" => "developer_apps#create"
  post "/developer_app/authenticate" => "developer_apps#authenticate"

  ### TEST ###

  root to: "tests#index"
  get "/test" => "tests#index"
end
