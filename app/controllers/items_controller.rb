class ItemsController < ApplicationController
	include ApplicationHelper
	before_filter :find_items
	
  def index
		@title = "Items"
		@new_item = Item.new	
	#	@item = Item.last
		@specs = Spec.all
  end

  def edit
		@item = Item.find(params[:id])
		@title = "Edit Item #{@item.code}"
  end

  def update
		logger.debug "Running items_controller.update"
		@item = Item.find(params[:id])
		@history = params[:history]
		@future = params[:future]
		case params[:commit]
		when 'Update'
			if _update
				flash[:success] = "Item updated"
				redirect_to items_path
			end
		when 'Update Item'
			if _update
				flash[:success] = "Item specs updated"
				redirect_to item_specs_path :item => @item, :history => @history, :future => @future
			end			
		else
			redirect_to items_path
		end
  end

  def new
		@item = Item.new
  end

  def create
		@item = Item.new(params[:item])
		@item.account_id = 1
		if @item.save
			flash[:success] = "Item added"
			cookies[:item_id] = @item.id
			redirect_to items_path
		else
			redirect_to items_path
		end
	end

  def destroy
		Item.find(params[:id]).destroy
		flash[:success] = "Item deleted"
		redirect_to items_path
  end
	
	def display
		if params.has_key?(:item)
			@item = Item.find(params[:item][:id])
		elsif params.has_key?(:item_id)
			@item = Item.find(params[:item_id])		
		else
			@item = Item.find(get_item_id)
		end
		cookies[:item_id] = @item.id
		@title = @item.code
		@item_specs = @item.item_specs
		@categories = @item_specs.group_by{|is| is.spec.category}
	end
	
	def _update
		@item.update_attributes(params[:item])
	end
	
	def find_items
		@items = Item.find(:all, :order => 'code')
	end

end
