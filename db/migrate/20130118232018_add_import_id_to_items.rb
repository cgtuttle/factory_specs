class AddImportIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :import_id, :integer
  end
end
