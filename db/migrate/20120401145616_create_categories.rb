class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :code, :null => false, :limit => 64
      t.string :name, :limit => 256
      t.integer :display_order

      t.timestamps
    end
  end
end
