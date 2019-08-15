Rails.application.routes.draw do


  devise_for :users
  root to: 'pages#discover'

  resources :businesses do
    resources :employees
    resources :products do
      resources :perks, only: [:show, :new, :create]
    end
    resources :perk_templates, only: [:new, :create]
  end

  resources :users, except: [:new, :create]

  resources :purchases, except: [:edit, :update, :destroy]



  get 'b_page', to: 'pages#business_page', as: 'test_business_page'
  get 'dashboard', to: 'pages#dashboard', as: 'dashboard_page'
end
