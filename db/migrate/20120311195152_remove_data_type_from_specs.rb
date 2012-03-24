class RemoveDataTypeFromSpecs < ActiveRecord::Migration
  def change
		remove_column :specs, :data_type
  end
end
