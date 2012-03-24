class RemovePurposeFromSpecs < ActiveRecord::Migration
  def up
		remove_column :specs, :purpose
  end

  def down
		add_column :specs, :purpose, :string
  end
end
