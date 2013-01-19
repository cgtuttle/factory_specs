class Import < ActiveRecord::Base
	has_many :cells
	# belongs_to :account
	
	accepts_nested_attributes_for :cells
	
	require 'csv'
	
	
	NO_IMPORT = %w[id created_at updated_at deleted deleted_at]
	MODELS = %w{Category Item ItemSpec Spec Test}

end
