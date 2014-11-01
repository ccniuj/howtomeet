Rails.application.routes.draw do
  root 'pages#index'
  
  get 'auth/:provider/callback', to: 'admin/events#open_new_file'
  get 'auth/failure', to: redirect('/')


  resources :pages, only: %i[index show]
  get '/info/:id', to: 'pages#info'
  resources :categories
  resources :meetups, only: %i[index show] do
    get 'find', on: :member
    resources :events, only: %i[index show]
  end
  resources :notes
  resources :images
  resources :reviews
  resources :attendees

  namespace :admin do
    resources :categories
    resources :meetups do
      get 'add', on: :member
      get 'remove', on: :member
      resources :events do
        get 'add', on: :member
        get 'remove', on: :member
        get 'open_new_file', on: :member
      end
    end
    resources :notes
    resources :images
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
