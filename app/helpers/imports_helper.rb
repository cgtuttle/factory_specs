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
			unless Import::NO_IMPORT.include?(c.name)
				@field_choices << [c.name.humanize, c.name]
			end
		end
	end
	
	def save_import
		@obj = @import.model.constantize
		(@first_row.to_i..@row_count.to_i).each do |i|
			@source = @import.cells.find_all_by_row(i)
			@import_row = Hash.new
			@source.each do |f|
				if f.field_name != "" && f.cell_value
					if f.field_name.last(3) == "_id"
						frgn_obj_name = f.field_name.slice(0..(f.field_name.size-4)).classify
						frgn_obj = frgn_obj_name.constantize
						if frgn_obj.exists?(:code => f.cell_value)
							frgn_obj_id = frgn_obj.find_by_code(f.cell_value).id
							@import_row[f.field_name] = frgn_obj_id
						end
					else	
						@import_row[f.field_name] = f.cell_value
					end			
				end
			end
			@save_row = @obj.new(@import_row)

			if @save_row.has_attribute?(:changed_by)
				@save_row.changed_by = current_user.email
			end

			if @save_row.save
				@source.each do |c|
					c.saved_at = Time.now
					c.save
				end	
			else
				@source.each do |c|
					c.had_save_error = true
					unless @save_row.errors[c.field_name].empty?
						c.save_error_text = "#{c.field_name.humanize} #{@save_row.errors[c.field_name]}"
					end
					c.save
				end
			end		
		end		
	end
	
end
