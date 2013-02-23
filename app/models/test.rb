class Test < ActiveRecord::Base
	validates :code, :presence => true, :uniqueness => {:scope => :account_id}
	has_many :item_specs

	default_scope { where(:account_id => Account.current_id)}
	
end
