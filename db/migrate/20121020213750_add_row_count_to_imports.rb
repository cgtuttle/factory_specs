class AddRowCountToImports < ActiveRecord::Migration
  def change
		add_column :imports, :row_count, :integer
  end
end
