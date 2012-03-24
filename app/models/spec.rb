class Spec < ActiveRecord::Base
	has_many :item_specs
	has_many :items, :through => :item_specs
	
	
	def self.filtered(filter)
		Spec.where('code LIKE ?', filter).order('code') | Spec.where('code NOT LIKE ?', filter).order('code')
	end
	
end
