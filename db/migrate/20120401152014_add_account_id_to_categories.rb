class AddAccountIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :account_id, :integer

  end
end
