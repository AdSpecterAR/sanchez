Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  ### USERS ###

  post "/users" => "users#create"

  ### DEVELOPER APPS ###

  post "/impressions" => "impressions#create"

  ### CAMPAIGNS ###

  post "/campaigns" => "campaigns#create"

  ### DEVELOPER APPS ###

  get "/developer_app" => "developer_apps#show"
  post "/developer_app" => "developer_apps#create"
end
