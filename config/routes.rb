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

  resources :users, except: [:new, :create] do
    resources :purchases, except: [:edit, :update, :destroy]
  end

  get 'b_page', to: 'pages#business_page', as: 'test_business_page'
  get 'dashboard', to: 'pages#dashboard', as: 'dashboard_page'
end
