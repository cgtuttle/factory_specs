class DropImportIdFromTables < ActiveRecord::Migration

	AFFECTED_TABLES = [:categories, :items, :specs, :tests]

	def change
		AFFECTED_TABLES.each do |t|
			remove_column t, :import_id
		end
	end

end
