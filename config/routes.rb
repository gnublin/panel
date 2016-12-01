Rails.application.routes.draw do
  resources :sites
  resources :pages
  root 'pages#index'
end
