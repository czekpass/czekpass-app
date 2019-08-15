Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#discover'

  resources :businesses do
    resources :employees
    resources :products do
      resources :perks, only: [:show]
    end
    resources :perk_templates
  end

  resources :users, except: [:new, :create]

  resources :purchases, except: [:edit, :update, :destroy]


  get 'business_dashboard', to: 'pages#business_dashboard', as: 'business_dashboard'
  get 'dashboard', to: 'pages#dashboard', as: 'dashboard_page'
end
