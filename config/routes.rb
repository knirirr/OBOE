Vibrant::Application.routes.draw do

  resources :jobs
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :tokens,:only => [:create, :destroy]
  resources :accounts

  require 'sidekiq/web'
  constraint = lambda { |request| request.env["warden"].authenticate? and request.env['warden'].user.admin? }
  constraints constraint do
    mount Sidekiq::Web => '/sidekiq'
  end

  root :to => "info#welcome" # a temporary redirection, should be to welcome

  post 'jobs/search(.:format)', :to => 'jobs#search'
  post 'left/view/:id', :to => 'jobs#leftstream'
  get 'left/view/:id', :to => 'jobs#leftstream'

  post 'jobs/new', :to => 'jobs#new'
  post 'show_all', :to => 'jobs#show_all'
  post 'users/toggle/:id', :to => 'user#toggle_left'
  post 'accounts/arrears/:id', :to => 'accounts#toggle_arrears'
  post 'accounts/:id', :to => 'accounts#show'

  put  'jobs/recreate/:id(.:format)', :to => 'jobs#recreate'
  put  'delete/:id(.:format)', :to => 'jobs#destroy' # as delete doesn't seem to offer the ability to authenticate

  get  'jobs/new', :to => 'jobs#new'
  get  'jobs/new/:type', :to => 'jobs#new'
  get  'jobs/search(.:format)', :to => 'jobs#index'
  get  'download/:id', :to => 'jobs#download'
  get  'download/infile/:id', :to => 'jobs#get_infile'
  get  'download/coords/:id(.:format)', :to => 'jobs#download_coords'
  get  'show_all', :to => 'jobs#show_all'
  get  'show_token', :to => 'user#show_token'
  get  'change_token', :to => 'user#change_token'
  get  'users/list', :to => 'user#list_users'
  get  'users/show/:id', :to => 'user#show_user'
  post  'users/show/:id', :to => 'user#show_user'
  get  'users/find', :to => 'user#find_users'
  post  'users/find', :to => 'user#find_users'
  get  'stats', :to => 'user#stats'
  get 'jobs/toggle/:id', :to => 'jobs#toggle_public'
  get 'jobs/status/:id', :to => 'jobs#get_status'

  get  'routes', :to => 'info#routes'
  get  'docs', :to => 'info#docs'
  #get  'left', :to => 'info#welcome_left'
  get  'left', :to => 'info#welcome'
  get  'home', :to => 'info#welcome'
  get  'privacy-policy', :to => 'info#privacy'
  get  'faq', :to => 'info#faq'
  get  'parameters/:type', :to => 'info#parameters'
  get  'types', :to => 'info#job_types'
  post  'types', :to => 'info#job_types'
  get  'information', :to => 'info#information'
  get  'undefined', :to => 'info#welcome'
  get  'inspect/:type/:id', :to => 'info#inspect'

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

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

end
