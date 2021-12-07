Rails.application.routes.draw do
  root 'home#index'
  post '/calc', to: 'home#calc'
  post '/rawcalc', to: 'home#rawcalc'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
