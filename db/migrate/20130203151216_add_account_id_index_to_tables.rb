class AddAccountIdIndexToTables < ActiveRecord::Migration
	AFFECTED_TABLES = [:categories, :imports, :items, :specs, :tests]

  def up
  	AFFECTED_TABLES.each do |t|
  		add_index t, [:account_id], :name => t.to_s.singularize + '_account'
  	end
  end

  def down
  	AFFECTED_TABLES.each do |t|
  		remove_index t, :name => t.to_s.singularize + '_account'
  	end
  end
end
