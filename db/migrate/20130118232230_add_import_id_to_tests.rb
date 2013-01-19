class AddImportIdToTests < ActiveRecord::Migration
  def change
    add_column :tests, :import_id, :integer
  end
end
