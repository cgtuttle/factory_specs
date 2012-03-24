class Item < ActiveRecord::Base
	has_many :item_specs
	has_many :specs, :through => :item_specs
	
	def self.filtered(filter)
		Item.where('code LIKE ?', filter).order('code') | Item.where('code NOT LIKE ?', filter).order('code')
	end
	
end
