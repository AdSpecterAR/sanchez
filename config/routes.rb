Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :app do
    namespace :v1 do
      post "/impressions" => "impressions#create"
    end
  end
end
