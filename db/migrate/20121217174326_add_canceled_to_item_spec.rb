class AddCanceledToItemSpec < ActiveRecord::Migration
  def change
    add_column :item_specs, :canceled, :boolean

  end
end
