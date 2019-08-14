Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  resources :businesses

  get 'b_page', to: 'pages#business_page', as: 'test_business_page'
end
