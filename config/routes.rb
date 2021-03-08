Rails.application.routes.draw do
  get 'about/show'
  get 'downloads/show'
  resources :documents
  get 'session/login'
  get 'session/logout'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
