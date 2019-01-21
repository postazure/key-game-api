Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :decks
  resources :games

  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout'
end
