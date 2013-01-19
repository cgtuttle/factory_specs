class AddDeletedToTests < ActiveRecord::Migration
  def change
    add_column :tests, :deleted, :boolean
    add_column :tests, :deleted_at, :datetime
  end
end
