Rails.application.routes.draw do
  
  get 'home/prices'
  post "home/prices" => 'home/prices'

  root 'home#index'
end
