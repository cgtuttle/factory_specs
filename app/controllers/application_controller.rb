class ApplicationController < ActionController::Base
  protect_from_forgery
	before_filter :authenticate_user!
	before_filter :set_dflt_item
	before_filter :set_dflt_content_id

	around_filter :scope_current_account
	
	
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

private

	def current_account
		Account.find(current_user.account_id)
	end
	helper_method :current_account

	def scope_current_account
		Account.current_id = current_account.id
logger.debug "running scope_current_account"
		yield
	ensure
		Account.current_id = nil
	end

end
