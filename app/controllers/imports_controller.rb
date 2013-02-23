class ImportsController < ApplicationController
	include ApplicationHelper
	include ImportsHelper
	
	def index
		@import = params[:id]
	end

	def new
		@import = Import.new
		if params[:model]
			@model = params[:model]
		end
		@title = "Import Data"
		@is_edit_form = true
	end
	
	def create
		if params[:file]
			if params[:import_file]=='Continue' # Continue button clicked
				@import = Import.new(params[:import])
				@import.user_id = 0 #current_user.id
				@model = @import.model #selected model
				@import.save
				import_file
				field_choices
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
			@field_choices = params[:field_choices]
			@import.first_row = @first_row
			@import.row_count = @row_count
			@import.cells.each do |cell|
				if cell.column <= @field_choices.length && cell.row >= params[:import][:first_row].to_i
					if @field_choices[cell.column-1] != 'Do not import'
						cell.field_name = @field_choices[cell.column-1]
					end
				end		
			end
			if @import.update_attributes(params[:import])
				if save_import
					flash[:success] = "Import completed successfully."
				else
					flash[:error] = "Import not completed"
				end
			end
		end
		redirect_to new_import_path
	end
	
end
