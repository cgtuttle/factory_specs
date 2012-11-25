class Item < ActiveRecord::Base
	has_many :item_specs
	has_many :specs, :through => :item_specs
	
	def self.filtered(filter)
		Item.where('code LIKE ?', filter).order('code') | Item.where('code NOT LIKE ?', filter).order('code')
	end

	def self.by_existence(id)
		@count = Item.count(:all)
		case @count
		when 0
			nil
		when 1
			Item.find(:first)			
		else
			if Item.exists?(id)
				logger.debug "Found item #{@item_id}"
				Item.find(id)
			else
				logger.debug "No Item - revert to first"
				Item.find(:first)				
			end	
		end	
	end

	def self.id_by_existence(id)
		if Item.by_existence(id).blank?
			0
		else
			Item.by_existence(id).id
		end
	end

end
