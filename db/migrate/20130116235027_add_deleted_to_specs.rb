class AddDeletedToSpecs < ActiveRecord::Migration
  def change
    add_column :specs, :deleted, :boolean
    add_column :specs, :deleted_at, :datetime
  end
end
