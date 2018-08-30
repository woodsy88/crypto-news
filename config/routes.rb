Rails.application.routes.draw do
  
  get 'home/prices'

  root 'home#index'
end
