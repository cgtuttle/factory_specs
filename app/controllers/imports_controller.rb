class ImportsController < ApplicationController
	include ApplicationHelper
	include ImportsHelper
#	before_filter { |c| c.set_zone "Application" }
	
	def new
		@import = Import.new
		if params[:model]
			@model = params[:model]
		end
	end
	
	def create
		if params[:file]
			if params[:import_file]=='Continue'
				@import = Import.new(params[:import])
				@import.account_id = 0 #current_account.id
				@import.user_id = 0 #current_user.id
				@model = @import.model
				@import.save
				import_file
					logger.debug "import_file complete"
				field_choices
					logger.debug "field_choices complete"
				render 'edit'
			else
				redirect_to new_import_path
			end
		else
			redirect_to new_import_path
		end
	end
	
	def edit
		@import = Import.find(params[:import])
	end
	
	def update
		if params[:import_file] == 'Import'
			@import = Import.find(params[:id])
			@first_row = params[:first_row]
			@row_count = params[:row_count]
					logger.debug "@row_count = #{@row_count}"
			@field_choices = params[:field_choices]
			@import.first_row = @first_row
			@import.row_count = @row_count
			@import.cells.each do |cell|
				if cell.column <= @field_choices.length && cell.row >= params[:import][:first_row].to_i
					cell.field_name = @field_choices[cell.column-1]
				end		
			end
			if @import.update_attributes(params[:import])
				save_import
				flash[:success] = "Import completed successfully."
			end
			@controller = @import.model.pluralize.downcase
			redirect_to :action => :index, :controller => @controller
		else
			redirect_to new_import_path
		end
	end
	
	
end
