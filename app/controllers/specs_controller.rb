class SpecsController < ApplicationController
	before_filter :find_specs
	
  def index
		@title = "Specification Definitions"
		@spec = Spec.new()
	end
	
	def new
		@spec = Spec.new()
	end
	
	def create
		if params[:commit] != 'Cancel'
			@spec = Spec.new(params[:spec])
			@spec.account_id = 1
			if @spec.save
				flash[:success] = "Definition added"
				redirect_to specs_path
			else
				redirect_to specs_path
			end
		else
			redirect_to specs_path
		end
	end

  def edit
		@spec = Spec.find(params[:id])
  end
	
	def update
		if params[:commit] != 'Cancel'
			@spec = Spec.find(params[:id])
			if @spec.update_attributes(params[:spec])
				flash[:success] = "Definition updated"
				redirect_to specs_path
			else
				redirect_to specs_path
			end
		else
			redirect_to specs_path
		end
	end
	
	def find_specs
		@specs = Spec.find(:all, :order => "display_order")
	end

end
