Rails.application.routes.draw do
  devise_for :users
  resources :sites do
    resources :pages
  end
  root 'sites#index'
end
