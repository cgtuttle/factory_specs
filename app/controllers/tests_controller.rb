class TestsController < ApplicationController

  def index
		@tests = Test.find(:all)
		@test = Test.new
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
