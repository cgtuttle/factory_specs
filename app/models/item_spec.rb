class ItemSpec < ActiveRecord::Base
	belongs_to :item
	belongs_to :spec
	belongs_to :test
	
	before_create :set_eff_date
	before_create :set_version
	
	def last_version
		if self.version
			ItemSpec.where(:item_id => self.item_id, :spec_id => self.spec_id).order('version DESC').first.version
		else
			0
		end
	end
	
	def date_status
		current_date = ItemSpec.where(["item_id = ? AND spec_id = ? AND eff_date <= ?", self.item_id, self.spec_id, Date.today] ).order('eff_date DESC, version DESC').first.eff_date
		if self.eff_date > current_date
			"future"
		elsif self.eff_date < current_date
			"past"
		else
			"current"
		end
	end
	
	def set_eff_date
		self.eff_date = Date.today
	end
	
	def set_version
		self.version = self.last_version + 1
	end
	
	
	
end
