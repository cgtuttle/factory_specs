class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :code, :limit => 64, :null => false
      t.string :name, :limit => 128
      t.integer :account_id, :null => false

      t.timestamps
    end
  end
end
