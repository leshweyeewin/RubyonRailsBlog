Rails.application.routes.draw do

  devise_for :users 

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  resources :post_comments
  resources :posts 
  resources :categories
  resources :tags
  resources :taggings

  get 'pages/about'
  get 'pages/contact'
  get 'pages/resources'
  
  get 'categories/index'
  get 'categories/new'
  get 'categories/edit'
  get 'categories/show'
  
  get 'home/index'
    
  get '/about' , :to => 'pages#about'
  get '/contact' , :to => 'pages#contact'
  get '/resources' , :to => 'pages#resources'
  get 'tagged', :to => 'posts#tagged', :as => :tagged
  get 'posts/:id/like', :to => 'posts#liked', :as => :liked
  get 'posts/:id/unlike', :to => 'posts#unliked', :as => :unliked

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => 'home#index'

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
  #     #     resources :sales do
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
