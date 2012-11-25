module ImportsHelper
	require 'csv'

	def import_file
		if params[:file]
			@column_count = 0
			@parsed_file=CSV.parse(params[:file].read)
			@row_count = 0
			@parsed_file.each_with_index do |row, i|
				row.each_with_index do |cell, j|
					@import_file = true
					@cell = @import.cells.new
					@cell.row = i + 1
					@cell.column = j + 1
					@cell.cell_value = cell
					@cell.import_id = @import.id
					@cell.save
					if j+1 > @column_count
						@column_count = j + 1					
					end
				end
				@row_count = i + 1
			end
		else
			@import_file = false
		end
	end
	
	def field_choices
		@obj = @model.constantize
		@field_choices = Array.new
		@obj.columns.each do |c|
			@import_field = true
			Import::NO_IMPORT.each do |n|
				if c.name == n
					@import_field = false
					break
				end
			end
			if @import_field
				@field_choices << [c.name, c.name]
			end
		end
	end
	
	def save_import
		@obj = @import.model.constantize
		(@first_row.to_i..@row_count.to_i).each do |i|
			@source = @import.cells.find_all_by_row(i)
			@import_row = Hash.new
			@source.each do |f|
				if f.field_name != ""
					@import_row[f.field_name] = f.cell_value
				end
			end
			@row = @obj.new(@import_row)
			@row.account_id = 0
			@row.save			
		end		
	end
	
end
