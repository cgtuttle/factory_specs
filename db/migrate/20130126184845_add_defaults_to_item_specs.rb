class AddDefaultsToItemSpecs < ActiveRecord::Migration
  def change
  	change_column :item_specs, :version, :integer, :default => 1
  	change_column :item_specs, :eff_date, :date, :default => Time.now
  end
end
