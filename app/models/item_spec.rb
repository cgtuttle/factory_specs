class ItemSpec < ActiveRecord::Base
	belongs_to :item
	belongs_to :spec
	belongs_to :test

	validates :item_id, :spec_id, :presence => true


	before_save :default_values
	
	def self.by_status(item)
		ItemSpec.includes(:spec => :category).where(:item_id => item).order("categories.display_order, specs.display_order, eff_date DESC, version DESC")
	end
	
	def date_status
		current_item_spec = ItemSpec
			.where(["item_id = ? AND spec_id = ? AND eff_date <= ?", self.item_id, self.spec_id, Date.today] )
			.order('eff_date DESC, version DESC').first
		if current_item_spec		
			current_date = current_item_spec.eff_date
			current_version = current_item_spec.version	
			if self.canceled
				"canceled"
			elsif (self.eff_date > Date.today)
				"pending"
			elsif self.deleted
				"deleted"
			elsif (self.eff_date == current_date and self.version < current_version) or self.eff_date < current_date
				"past"
			else
				"current"
			end
		else
			if self.canceled
				"canceled"
			else
				"future"
			end
		end
	end

	def set_version
		self.version = ((self.last_version.nil? && 0) || self.last_version) + 1
	end
	
	def last_version
		unless ItemSpec.where(:item_id => self.item_id, :spec_id => self.spec_id).empty?
			ItemSpec.where(:item_id => self.item_id, :spec_id => self.spec_id).order('version DESC').first.version
		end
	end
	
	def set_eff_date
		if !self.eff_date
			self.eff_date = Date.today
		end
	end

	def set_editor(user)
		self.changed_by = user
	end

	def default_values
		self.eff_date ||= Time.now
		self.string_value ||= ""
		self.text_value ||= ""
	end

end
