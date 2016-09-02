ApiApp::Application.routes.draw do
  mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :users
  # Api definition
  namespace :api, defaults: { format: :json } do
    resources :users
    resources :sessions, :only => [:create, :destroy]
    resources :products, :only => [:show, :index, :create, :destroy]
    
    resources :comments, only:[:create]


    get 'like_dislike' => 'likes#like_dislike'
    get 'liked_users' => 'likes#liked_users'
    get 'disliked_users' => 'likes#disliked_users'
    get 'my_likers' => 'likes#my_likers'
    get 'my_dislikers' => 'likes#my_dislikers'
    get 'other_users' => 'likes#other_users'

    get 'location_based' => 'articles#location_based'


    resources :articles, :only => [:create, :index, :show]
    
    get 'my_articles' => 'articles#my_articles'
    get 'my_favourite_articles' => 'articles#my_favourite_articles'
    post 'article_ratings' => 'articles#article_ratings'

    post 'voting_disvoting' => 'votings#voting_disvoting'

    get 'location_based' => 'articles#location_based'
    

    resources :conversations, :only => [:index, :create]

    get 'list_messages' => 'conversations#list_messages'
    get 'all_users' => 'conversations#all_users'

    get 'blocked_users' => 'blocks#blocked_users'
    get 'unblocked_users' => 'blocks#unblocked_users'
    get 'blocks' => 'blocks#blocks'
    get 'neutral_users' => 'blocks#neutral_users'
    
  end
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
