class AddDeletedToItems < ActiveRecord::Migration
  def change
    add_column :items, :deleted, :boolean
    add_column :items, :deleted_at, :datetime
  end
end
