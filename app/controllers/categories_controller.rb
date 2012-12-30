class CategoriesController < ApplicationController
  
	def index
		@title = 'Categories'
		@categories = Category.order('display_order').paginate(:page => params[:page], :per_page => 30)
		@index = @categories
		@category = Category.new
		@span = 5
		@is_index_table = true
logger.debug "@index = #{@index.inspect}"
	end
	
	def create
		if params[:commit] != 'Cancel'
			@category = Category.new(params[:category])
			@category.account_id = 1
			order = (params[:category][:display_order]).to_i
			@category.reorder(order)
			if @category.save
				flash[:success] = "Category added"
			end
		end
		redirect_to categories_path
	end

  def edit
		@category = Category.find(params[:id])
		@title = "Edit Category: #{@category.name}"
		@is_edit_form = true
	end
	
	def update
		if params[:commit] != 'Cancel'
			@category = Category.find(params[:id])
			order = (params[:category][:display_order]).to_i
			@category.reorder(order)
			if @category.update_attributes(params[:category])
				flash[:success] = 'Category updated'
			end
		end
		redirect_to categories_path
	end
end
