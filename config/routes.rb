Rails.application.routes.draw do
  root 'downloads#index', as: 'download'

  get 'about', to: 'about#show', as: 'about'
  put '/', to: 'downloads#submit_code'

  get 'dashboard', to: 'documents#index', as: 'documents_dashboard'
  get 'dashboard/:id', to: 'documents#show', as: 'document_dashboard'
  get 'upload', to: 'documents#new', as: 'upload_file'

  post 'upload', to: 'documents#create'
  post 'distribute/:id', to: 'documents#distribute'

  get  'signup',  to: 'users#new',    as: 'get_signup'
  post 'signup', to: 'users#create', as: 'post_signup'

  controller :sessions do
    get    'login'  =>  :new
    post   'login'  =>  :create
    delete 'logout' =>  :destroy
  end

  resources :documents
  resources :users
end
