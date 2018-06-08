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

  put "/impressions/:impression_id/shown" => "impressions#shown"
  post "/impressions/:impression_id/shown" => "impressions#shown"

  put "/impressions/:impression_id/clicked" => "impressions#clicked"
  post "/impressions/:impression_id/clicked" => "impressions#clicked"

  ### AD UNITS ###

  get "/ad_units/default" => "ad_units#default"
  get "/ad_units/fetch" => "ad_units#fetch"
  post "/ad_units" => "ad_units#create"

  ### DEVELOPER APPS ###

  get "/developer_app" => "developer_apps#show"
  post "/developer_app" => "developer_apps#create"
  
  put "/developer_app/authenticate" => "developer_apps#authenticate"
  post "/developer_app/authenticate" => "developer_apps#authenticate"

  ### ATTRIBUTION ###

  get "/postback/:attribution_partner/install" => "impressions#installed"
  get "/postback/:attribution_partner/click" => "impressions#clicked"
  get "/postback/:attribution_partner/impression" => "impressions#shown"

  ### TEST ###

  root to: "tests#index"
  get "/test" => "tests#index"
end
