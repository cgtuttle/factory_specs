class RollbackLastMigration < ActiveRecord::Migration
  def up  	
  	change_column :item_specs, :eff_date, :date, :default => nil
  end

  def down  	
  	change_column :item_specs, :eff_date, :date, :default => Time.now
  end
end
