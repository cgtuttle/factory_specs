class ApplicationController < ActionController::Base
  protect_from_forgery
	before_filter :set_dflt_item
	
	def set_dflt_item
		if cookies[:item_id]
			@item = Item.find(cookies[:item_id])
		else
			@item = Item.first
		end
	end

	def after_sign_in_path_for(resource)
		display_items_path(:item_id => @item.id )
	end

end
