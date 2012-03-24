class RenameOrderInSpecsToDisplayOrder < ActiveRecord::Migration
  def change
		rename_column :specs, :order, :display_order
  end
end
