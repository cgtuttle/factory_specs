class ItemSpecsController < ApplicationController
	
  def index
		set_scope
		@title = 'Item Specifications'
		@q = ItemSpec.search(params[:q])
		@spec_filter = "#{params[:q][:spec_code_cont]}%"
		@item_filter = "#{params[:q][:item_code_cont]}%"
		@item_specs = @q.result(:distinct => true).joins(:item, :spec).order('items.code, specs.code, eff_date, version DESC')
		@item_spec = ItemSpec.new()
		@item_spec.eff_date = Date.today
  end
	
	def create
		@q = params[:q]
		@future = params[:include_future]
		@history = params[:include_history]
		@deleted = params[:include_deleted]
		
		if params[:commit] != 'Cancel'
			@item_spec = ItemSpec.new(params[:item_spec])
			@item_spec.version = @item_spec.last_version + 1
			if @item_spec.save
				case params[:commit]
				when "Add Item Spec" 
					flash[:success] = "Item Specification added"
				when "Submit Changes"
					flash[:success] = "Item Specification updated"
				else
					flash[:success] = "Updates Successful"
				end
				redirect_to item_specs_path :q => @q, :include_future => @future, :include_history => @history, :include_deleted => @deleted
			else
				redirect_to item_specs_path :q => @q, :include_future => @future, :include_history => @history, :include_deleted => @deleted
			end
		else
			redirect_to item_specs_path :q => @q, :include_future => @future, :include_history => @history, :include_deleted => @deleted
		end
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
