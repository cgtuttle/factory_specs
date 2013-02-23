class AddDefaultToDeletedInTables < ActiveRecord::Migration

	AFFECTED_TABLES = [:categories, :items, :specs, :tests]

  def up
  	AFFECTED_TABLES.each do |t|
  		change_column_default t, :deleted, false
  	end
  end

  def down
  	AFFECTED_TABLES.each do |t|
  		change_column_default t, :deleted, nil
  	end
  end
end
