Funbet::Application.routes.draw do
  root to: 'dashboards#index'

  resources :authentications
  resources :sessions
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout

  resources :users

	resources :bets
end
