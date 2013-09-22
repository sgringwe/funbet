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
    post 'agree' => 'bets#agree', as: :agree
    post 'disagree' => 'bets#disagree', as: :disagree
    post 'complete' => 'bets#complete', as: :complete
  end

end
