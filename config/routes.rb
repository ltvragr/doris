Doris::Application.routes.draw do

  get "home/index", as: :home

  get 'tags/:tag' => 'projects#index', as: :tag
  resources :tags
  resources :info_fields
  resources :labs
  resources :users
  resources :projects
  resources :home

  match '/users/:id/edit_info_fields' => 'users#edit_info_fields', as: :edit_info_fields
  match '/users/:id' => 'users#update_info_fields', as: :update_info_fields
  match '/logout' => 'users#logout', as: :logout
  match '/authorize/:id' => 'labs#authorize', as: :authorize
  match '/confirm/:id' => 'projects#confirm', as: :confirm
  match '/add_self_to_project/:id' => 'projects#add_self_to_project', as: :add_self_to_project
  match '/remove_self_from_project/:id' => 'projects#remove_self_from_project', as: :remove_self_from_project
  get '/search' => 'search#search', as: :search
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: 'public#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

end
