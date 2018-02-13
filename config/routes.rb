Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  ### USERS ###

  post "/users" => "users#create"
  get "/users" => "users#index"

  ### IMPRESSIONS ###

  post "/impressions" => "impressions#create"
  post "/impressions/:id" => "impressions#update"

  ### CAMPAIGNS ###

  post "/campaigns" => "campaigns#create"

  ### DEVELOPER APPS ###

  get "/developer_app" => "developer_apps#show"
  post "/developer_app" => "developer_apps#create"
  post "/developer_app/authenticate" => "developer_apps#authenticate"

  ### TEST ###

  get "/test" => "tests#index"
end
