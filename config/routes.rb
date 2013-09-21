Funbet::Application.routes.draw do
  root to: 'dashboards#index'

	resources :bets
end
