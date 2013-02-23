class AddNotesToItemSpecs < ActiveRecord::Migration
  def change
    add_column :item_specs, :notes, :text
  end
end
