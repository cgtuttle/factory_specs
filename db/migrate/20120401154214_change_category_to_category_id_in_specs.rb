class ChangeCategoryToCategoryIdInSpecs < ActiveRecord::Migration
  def up
		add_column :specs, :category_id, :integer
		remove_column :specs, :category
  end

  def down
		remove_column :specs, :category_id
		add_column :specs, :category, :string
  end
end
