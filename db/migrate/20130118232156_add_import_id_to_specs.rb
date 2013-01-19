class AddImportIdToSpecs < ActiveRecord::Migration
  def change
    add_column :specs, :import_id, :integer
  end
end
