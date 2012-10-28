class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.integer :import_id
      t.integer :row
      t.integer :column
      t.string :cell_value
      t.string :field

      t.timestamps
    end
  end
end
