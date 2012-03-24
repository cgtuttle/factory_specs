class CreateSpecs < ActiveRecord::Migration
  def change
    create_table :specs do |t|
      t.string :code, :limit => 64, :null => false
      t.string :name, :limit => 128
      t.string :type, :limit => 64
      t.string :category, :limit => 64
      t.boolean :usl
      t.boolean :lsl
      t.text :purpose
      t.string :label, :limit => 64
      t.integer :order
      t.integer :account_id, :null => false
			t.string :created_by
			t.string :changed_by

      t.timestamps
    end
  end
end
