Rails.application.routes.draw do

  root 'products#index'
  get 'products/upload', as: :upload
  get 'manifests/:id' => 'manifests#show', as: :manifest, :defaults => { :format => :xml }
  get '/ssl_test' => 'manifests#ssl_test'
  get '/install_certificate' => 'home#install_certificate'
  get 'login' => 'sessions#identity_login', as: :login
  get 'eflogin' => 'sessions#new', as: :eflogin
  get '/logout' => 'sessions#destroy'
  get '/auth/failure', to: 'sessions#failure'
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :products do 
    resources :releases
    resources :groups
  end
  resources :ios_releases
 
  resources :users, only: [:show, :index]
  resources :groups

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
