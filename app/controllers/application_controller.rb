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
end
