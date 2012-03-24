class AddPrecisionAndSizeToDecimals < ActiveRecord::Migration
  def up		
		change_column :item_specs, :numeric_value, :decimal, :precision => 38, :scale => 19
		change_column :item_specs, :lsl, :decimal, :precision => 38, :scale => 19
		change_column :item_specs, :usl, :decimal, :precision => 38, :scale => 19
  end
	
	def down
		change_column :item_specs, :numeric_value, :decimal
		change_column :item_specs, :lsl, :decimal
		change_column :item_specs, :usl, :decimal
	end
end
