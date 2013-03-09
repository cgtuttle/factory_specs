Factory::Application.routes.draw do
	
	devise_for :users

	resources :accounts
	resources :imports
  	resources :item_specs
	resources :items do
		collection do
			get 'display'
		end
	end
	resources :specs
	resources :categories
	resources :tests
#	resources :users
	
	match 'item_specs/:id/cancel' => 'item_specs#cancel', :as => :cancel_item_spec
	match 'item_specs/:id/copy' => 'item_specs#copy', :as => :copy_item_spec
	match 'test/:id/instructions' => 'tests#instructions'
	match 'item_specs/:id/notes' => 'item_specs#notes', :as => :notes

	root :to => 'main#welcome'
	
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

 
  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

end
