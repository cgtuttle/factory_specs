class ItemsController < ApplicationController
	before_filter :find_items
	
  def index
		@title = "Items"
		@new_item = Item.new	
		@item = Item.last
		@specs = Spec.all
  end

  def edit
		@item = Item.find(params[:id])
		@title = "Edit Item #{@item.code}"
  end

  def update
		@item = Item.find(params[:id])
		case params[:commit]
		when 'Update'
			if _update
				flash[:success] = "Item updated"
				redirect_to items_path
			end
		when 'Update item'
			if _update
				flash[:success] = "Item specs updated"
				redirect_to item_specs_path :item => @item
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
	
	def _update
		if @item.update_attributes(params[:item])
			true
		else
			false
		end
	end
	
	def find_items
		@items = Item.find(:all, :order => 'code')
	end

end
