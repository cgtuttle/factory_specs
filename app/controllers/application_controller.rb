class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
	before_filter :set_dflt_item
	before_filter :set_dflt_content_id
	
	
	def set_dflt_item
		@item_id = cookies[:item_id] ? cookies[:item_id] : 0
		@item = Item.by_existence(@item_id)
		if @item.blank?
			@item_id = 0
		end
	end

	def set_dflt_content_id
		@content_id = ""
	end
	
	def after_sign_in_path_for(resource)
		display_items_path(:item_id => @item_id )
	end

end
