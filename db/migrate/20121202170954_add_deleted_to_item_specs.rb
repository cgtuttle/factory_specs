class AddDeletedToItemSpecs < ActiveRecord::Migration
  def change
    add_column :item_specs, :deleted, :boolean, :default => 'FALSE'

  end
end
