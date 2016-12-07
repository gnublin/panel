Rails.application.routes.draw do
  namespace :admin do
    resources :accounts
  end

  devise_for :users
  resources :sites do
    resources :pages
  end
  root 'sites#index'
end
