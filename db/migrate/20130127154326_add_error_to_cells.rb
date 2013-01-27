class AddErrorToCells < ActiveRecord::Migration
  def change
    add_column :cells, :had_save_error, :boolean
    add_column :cells, :save_error_text, :string
  end
end
