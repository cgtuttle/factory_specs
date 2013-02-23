class CategoriesController < ApplicationController
  
	def index
		@title = 'Categories'
		@categories = Category.where(:deleted => false).order('display_order').paginate(:page => params[:page], :per_page => 30)
		@index = @categories
		@category = Category.new
		@span = 6
		@is_index_table = true
	end
	
	def create
		if params[:commit] != 'Cancel'
			@category = Category.new(params[:category])
			order = (params[:category][:display_order]).to_i
			@category.reorder(order)
			if @category.save
				flash[:success] = "Category added"
			else
				flash[:error] = "Category could not be added"
#TODO Add more descriptive error messages
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
		else
			flash[:success] = 'Update canceled'
		end
		redirect_to categories_path
	end

	def destroy
		@category = Category.find(params[:id])
		now = Time.now
		if @category.update_attributes(:deleted => 'true', :deleted_at => now )
			flash[:success] = 'Category deleted'
		end
		redirect_to categories_path
	end

end
