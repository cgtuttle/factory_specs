class AddDeletedToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :deleted, :boolean
    add_column :categories, :deleted_at, :datetime
  end
end
