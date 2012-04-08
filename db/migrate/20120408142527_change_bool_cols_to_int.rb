class ChangeBoolColsToInt < ActiveRecord::Migration
  def up
		change_column :specs, :usl, :integer
		change_column :specs, :lsl, :integer
  end

  def down
		change_column :specs, :usl, :boolean
		change_column :specs, :lsl, :boolean
  end
end
