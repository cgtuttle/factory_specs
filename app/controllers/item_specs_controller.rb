class ItemSpecsController < ApplicationController
	
  def index
		set_scope
		@title = 'Item Specifications'
		if params[:commit] =='Apply'
			@item = Item.find(params[:item_spec][:item_id])
		end
		@item_specs = ItemSpec.where(:item_id => @item.id)
		@specs = Spec.order(:code)
		@items = Item.order(:code)
  end
	
	
	def edit	
		@existing_item_spec = ItemSpec.find(params[:id])		
		@item_spec = ItemSpec.new(@existing_item_spec.attributes)
		@item_spec.eff_date = Date.today
	end
	
	def destroy
		ItemSpec.find(params[:id]).destroy
		flash[:success] = "Item Spec deleted"
		redirect_to item_specs_path
  end
	
	def set_scope
		
		if params[:item] && !params[:item].blank?
			@item = Item.find(params[:item])
		else
			@item = Item.order(:code).first
		end
		
		if params[:include_future] && !params[:include_future].blank?
			@future = params[:include_future] == "future"
		else
			@future = false
		end
		
		if params[:include_history] && !params[:include_history].blank?
			@history = params[:include_history] == "history"
		else
			@history = false
		end
		
		if params[:include_deleted] && !params[:include_deleted].blank?
			@deleted = params[:include_deleted] == "deleted"
		else
			@deleted = false
		end
	end
	
end
