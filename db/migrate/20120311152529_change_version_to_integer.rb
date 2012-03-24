class ChangeVersionToInteger < ActiveRecord::Migration
  def up
		change_table :item_specs do |t|
			t.change :version, :integer
		end
  end

  def down
		change_table :item_specs do |t|
			t.change :version, :string
		end
  end
end
