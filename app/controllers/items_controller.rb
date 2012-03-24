class ItemsController < ApplicationController
	before_filter :find_items
	
  def index
		@title = "Items"
		@item = Item.new
  end

  def edit
		@item = Item.find(params[:id])
		@title = "Edit Item #{@item.code}"
  end

  def update
		if params[:commit] == 'Update'
			@item = Item.find(params[:id])
			if @item.update_attributes(params[:item])
				flash[:success] = "Item updated"
				redirect_to items_path
			else
				redirect_to items_path
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
	
	def find_items
		@items = Item.find(:all, :order => 'code')
	end

end
