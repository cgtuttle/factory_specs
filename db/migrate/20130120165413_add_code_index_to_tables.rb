class AddCodeIndexToTables < ActiveRecord::Migration
  AFFECTED_TABLES = [:categories, :items, :specs, :tests]

	def change
		AFFECTED_TABLES.each do |t|
			add_index t, [:account_id, :code], :unique => true, :name => t.to_s.singularize + '_by_code'
		end
	end
end
