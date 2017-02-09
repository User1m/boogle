Rails.application.routes.draw do
  post '/index' => 'search_engine#index'
  get '/search' => 'search_engine#search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
