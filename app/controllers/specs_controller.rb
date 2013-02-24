class SpecsController < ApplicationController
	load_and_authorize_resource
	before_filter :find_specs
	
  def index
		@title = "Specification Definitions"
		@spec = Spec.new()
		@is_index_table = true
		@span = 8
	end
	
	def new
		@spec = Spec.new()
	end
	
	def create
		if params[:commit] != 'Cancel'
			@spec = Spec.new(params[:spec])
			order = (params[:spec][:display_order]).to_i
			@spec.reorder(order)
			if @spec.save
				flash[:success] = "Definition added"
				redirect_to specs_path
			else
				flash[:error] = "Definition could not be added"
#TODO Add more descriptive error messages
				redirect_to specs_path
			end
		else
			redirect_to specs_path
		end
	end

  def edit
		@spec = Spec.find(params[:id])
		@is_edit_form = true
		@title = "Specification: #{@spec.name}"
  end
	
	def update
		if params[:commit] != 'Cancel'
			@spec = Spec.find(params[:id])
			order = (params[:spec][:display_order]).to_i
			@spec.reorder(order)
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
		@specs = Spec.where(:deleted => false).order("display_order").paginate(:page => params[:page], :per_page => 20)
		@index = @specs
	end

end
