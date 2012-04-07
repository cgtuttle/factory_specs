class CategoriesController < ApplicationController
  
	def index
		@categories = Category.find(:all)
		@category = Category.new
	end
	
	def create
		if params[:commit] != 'Cancel'
			@category = Category.new(params[:category])
			@category.account_id = 1
			if @category.save
				flash[:success] = "Category added"
			end
		end
	end

  def edit
		@category = Category.find(params[:id])
	end
	
	def update
		if params[:commit] != 'Cancel'
			@category = Category.find(params[:id])
			if @category.update_attributes(params[:category])
				flash[:success] = 'Category updated'
			end
		end
		redirect_to categories_path
	end
end
