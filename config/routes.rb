Rails.application.routes.draw do
  get 'home/index'
  get 'home/profile'
  get '/profile', to: 'home#profile'


  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
