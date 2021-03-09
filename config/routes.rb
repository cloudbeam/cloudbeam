Rails.application.routes.draw do
  root 'downloads#index', as: 'download'

  get 'about/show'
  put 'downloads' => 'downloads#show'
  
  resources :documents
  get 'session/login'
  get 'session/logout'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
