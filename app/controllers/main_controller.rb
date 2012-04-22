class MainController < ApplicationController
  def contents
		@items = Item.order('code').all
  end
	
	def display
		redirect_to display_item_path(params[:selected_item])
	end

end
