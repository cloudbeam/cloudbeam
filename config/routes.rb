Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  get 'errors/not_found'
  get 'errors/internal_server_error'
  root 'downloads#index', as: 'download'

  get 'about', to: 'about#show', as: 'about'
  get 'team', to: 'team#index', as: 'team'

  get 'dashboard', to: 'documents#index', as: 'documents_dashboard'
  get 'dashboard/:id', to: 'documents#show', as: 'document_dashboard'
  get 'upload', to: 'documents#new', as: 'upload_file'

  post 'upload', to: 'documents#create'
  post 'distribute/:id', to: 'documents#distribute'
  get '/distributeagain', to: 'documents#distribute_again'

  get  'signup',  to: 'users#new',    as: 'get_signup'
  post 'signup',  to: 'users#create', as: 'post_signup'

  controller :downloads do
    get  '/downloads'  => :index
    post '/downloads'  => :submit_code
    post '/file_owner_download', to: 'downloads#file_owner_download'
  end

  controller :sessions do
    get    'login'  =>  :new
    post   'login'  =>  :create
    get    'logout' =>  :destroy
  end

  resources :password_resets

  resources :documents
  resources :users

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end
