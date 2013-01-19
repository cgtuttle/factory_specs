class AddImportIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :import_id, :integer
  end
end
