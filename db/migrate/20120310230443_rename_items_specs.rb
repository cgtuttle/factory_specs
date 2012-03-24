class RenameItemsSpecs < ActiveRecord::Migration
  def change
		rename_table :items_specs, :item_specs
  end
end
