Rails.application.routes.draw do
  resources :sites do
    resources :pages
  end
  root 'sites#index'
end
