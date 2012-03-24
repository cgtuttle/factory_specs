class CreateItemsSpecs < ActiveRecord::Migration
  def change
    create_table :items_specs do |t|
      t.integer :item_id
      t.integer :spec_id
      t.string :version, :limit => 32
      t.date :eff_date
      t.string :tag
      t.integer :test_id
			t.string :changed_by
			t.decimal :numeric_value
			t.string :string_value
			t.text :text_value
			t.string :document_title
			t.string :document_url
			t.string :document_version, :limit => 32
			t.decimal :lsl
			t.decimal :usl
			t.string :unit_of_measure, :limit => 64

      t.timestamps
    end
  end
end
