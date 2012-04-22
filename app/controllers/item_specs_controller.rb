class ItemSpecsController < ApplicationController
	
  def index
		set_scope
		if params.has_key?(:item_spec)
			@item = Item.find(params[:item_spec][:item_id])
		else
			@item = Item.first
		end
		#if params[:item_id]
			#@item = Item.find(params[:item_id])
		#end
		#if params[:item_spec][:item_id]
			#@item = Item.find(params[:item_spec][:item_id])
		#end
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
		
		@future = params[:include_future] && !params[:include_future].blank?
		@history = params[:include_history] && !params[:include_history].blank?
		@deleted = params[:include_deleted] && !params[:include_deleted].blank?
		
	end
	
end
