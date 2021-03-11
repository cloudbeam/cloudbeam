Rails.application.routes.draw do
  root 'downloads#index', as: 'download'

  get 'about', to: 'about#show', as: 'about'
  put '/', to: 'downloads#submit_code'

  get '/login', to: 'session#login', as: 'get_login'
  post '/login', to: 'session#create', as: 'post_login'
  get 'logout', to: 'session#logout', as: 'logout'
  get 'dashboard', to: 'documents#index', as: 'documents_dashboard'
  get 'dashboard/:id', to: 'documents#show', as: 'document_dashboard'
  get 'upload', to: 'documents#new', as: 'upload_file'

  post 'upload', to: 'documents#create'
  post 'distribute/:id', to: 'documents#distribute'

  get 'signup', to: 'users#new', as: 'get_signup'
  post 'signup', to: 'users#create', as: 'post_signup'
  
  resources :documents
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
