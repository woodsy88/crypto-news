Rails.application.routes.draw do
  
  resources :cryptos
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end


  devise_for :users, :controllers => {:registrations => "registrations"}


  get 'home/prices'
  post "home/prices" => 'home/prices'

  get 'home/lookup'
  
  # lookupform route
  post "/home/lookup" => 'home/lookup'

  root 'home#index'
end
