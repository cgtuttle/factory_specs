class ItemSpec < ActiveRecord::Base
	belongs_to :item
	belongs_to :spec
	belongs_to :test
	
	before_create :set_eff_date
	before_create :set_version
	
	def self.by_item(item_id)
		ItemSpec.joins(:spec => :category).where(:item_id => item_id).order('categories.display_order, specs.display_order, item_specs.eff_date DESC, item_specs.version DESC')
	end
	
	def last_version
		if self.version
			ItemSpec.where(:item_id => self.item_id, :spec_id => self.spec_id).order('version DESC').first.version
		else
			0
		end
	end
	
	def date_status
		current_item_spec = ItemSpec.where(["item_id = ? AND spec_id = ? AND eff_date <= ?", self.item_id, self.spec_id, Date.today] ).order('eff_date DESC, version DESC').first
		current_date = current_item_spec.eff_date
		current_version = current_item_spec.version	
		if self.eff_date > current_date
			"future"
		elsif (self.eff_date == current_date and self.version < current_version) or self.eff_date < current_date
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
