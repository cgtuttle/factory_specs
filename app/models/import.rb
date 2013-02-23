class Import < ActiveRecord::Base
	has_many :cells

	default_scope { where(:account_id => Account.current_id)}
	
	accepts_nested_attributes_for :cells
	
	require 'csv'
	
	NO_IMPORT = %w[id created_at updated_at deleted deleted_at canceled account_id]
	MODELS = %w[Category Item ItemSpec Spec Test]
	MODELS_WITH_FK = ["ItemSpec"]

	

end
