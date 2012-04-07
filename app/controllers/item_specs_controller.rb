class ItemSpecsController < ApplicationController
	
  def index
		set_scope
		if params[:commit] =='Apply'
			@item = Item.find(params[:item_spec][:item_id])
		end
		if params[:item_id]
			@item = Item.find(params[:item_id])
		end
		@title = "Specifications for #{@item.code}"
		#@item_specs = ItemSpec.where(:item_id => @item.id)
		@item_specs = ItemSpec.by_item(@item.id)
		@specs = Spec.order(:code)
		@items = Item.order(:code)
  end
	
	
	def edit	
		@item_spec = ItemSpec.find(params[:id])
		@new_item_spec = @item_spec.dup
	end
	
	def create
		@new_item_spec = ItemSpec.new(params[:item_spec])
		@new_item_spec.save
		redirect_to item_specs_path :item_id => params[:item_spec][:item_id]
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
