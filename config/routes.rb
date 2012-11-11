Factory::Application.routes.draw do
	
  devise_for :users

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
	
	match 'test/:id/instructions' => 'tests#instructions'
	#match '/display' => 'items#display', :via => :get
	
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
