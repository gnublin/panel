Rails.application.routes.draw do
  namespace :admin do
    resources :accounts
  end

  devise_for :users
  resources :sites do
    resources :pages do
      post :run_check_job
      resources :runs, shallow: true
    end
  end
  root 'static#home'

end
