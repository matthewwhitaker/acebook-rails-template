Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :friendships
  resources :posts do
    resources :likes
  end
  root to: 'posts#index'
end
