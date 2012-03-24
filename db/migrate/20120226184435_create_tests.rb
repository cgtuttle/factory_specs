class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :code, :limit => 64, :null => false
      t.string :name, :limit => 128
      t.text :instructions
			t.integer :account_id, :null => false

      t.timestamps
    end
  end
end
