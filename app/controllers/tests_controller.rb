class TestsController < ApplicationController

  def index
  	@title = 'Tests'
		@tests = Test.find(:all).paginate(:page => params[:page], :per_page => 30)
		@index = @tests
		@test = Test.new
		@span = 4
		@is_index_table = true
	end
	
	def create
		if params[:commit] != 'Cancel'
			@test = Test.new(params[:test])
			@test.account_id = 1
			if @test.save
				flash[:success] = "test added"
			end
		end
		redirect_to tests_path
	end

  def edit
		@test = Test.find(params[:id])
		@title = "Edit Test: #{@test.name}"
		@is_edit_form = true		
	end
	
	def update
		if params[:commit] != 'Cancel'
			@test = Test.find(params[:id])
			if @test.update_attributes(params[:test])
				flash[:success] = 'test updated'
			end
		end
		redirect_to tests_path
	end
	
	def instructions
		@test = Test.find(params[:id])
	end
end
