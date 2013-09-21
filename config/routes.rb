Funbet::Application.routes.draw do
  root to: 'dashboards#index'

  resources :authentications
  resources :sessions
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout

	get '/auth/:provider/callback', to: 'sessions#create'

  resources :users
  get 'register' => 'users#new', as: :register

  resources :bets do
    post 'challenge/:choice' => 'bets#challenge', as: :challenge
    post 'complete/:choice' => 'bets#complete', as: :complete
  end

end
