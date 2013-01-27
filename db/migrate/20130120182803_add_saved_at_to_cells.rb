class AddSavedAtToCells < ActiveRecord::Migration
  def change
    add_column :cells, :saved_at, :datetime
  end
end
