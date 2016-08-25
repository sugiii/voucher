Rails.application.routes.draw do
  resources :msgforms
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'msgforms#index'

  post '/msgforms/save' => 'msgforms#save', :as => :msgforms_save
  post '/msgforms/save_test' => 'msgforms#save_test', :as => :msgforms_save_test
  post '/msgforms/send_msg' => 'msgforms#send_msg', :as => :msgforms_send_msg
  post '/msgforms/delete' => 'msgforms#delete', :as => :msgforms_delete
  post '/msgforms/load' => 'msgforms#load', :as => :msgforms_load
  post '/msgforms/dataload' => 'msgforms#dataload', :as => :msgforms_dataload
  post '/msgforms/histload' => 'msgforms#histload', :as => :msgforms_histload
  post '/msgforms/load_testdata' => 'msgforms#load_testdata', :as => :msgforms_load_testdata
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
