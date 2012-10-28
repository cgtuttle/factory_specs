class ChangeCellsNameField < ActiveRecord::Migration
  def change
		rename_column :cells, :field, :field_name
  end

end
