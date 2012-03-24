class ChangeTypeToDataTypeInSpecs < ActiveRecord::Migration
  def change
		rename_column :specs, :type, :data_type		
  end
end
