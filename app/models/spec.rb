class Spec < ActiveRecord::Base
	has_many :item_specs
	has_many :items, :through => :item_specs
	belongs_to :category
	
	
	def self.filtered(filter)
		Spec.where('code LIKE ?', filter).order('code') | Spec.where('code NOT LIKE ?', filter).order('code')
	end
	
	def reorder(new)
		old = self.id ? self.display_order : 0
		if new < old
			self.display_order = new
			self.save
			Spec.where('display_order >= ? AND display_order <= ? AND id != ?', new, old, self.id).update_all("display_order = display_order + 1") 
		elsif new > old && old > 0
			self.display_order = new
			self.save
			Spec.where('display_order >= ? AND display_order <= ? AND id != ?', old, new, self.id).update_all("display_order = display_order - 1")
		elsif old == 0
			specs = Spec.where('display_order >= ?', new).update_all("display_order = display_order + 1")
		end
		if old != new && old > 0
			i = 1
			specs = Spec.order('display_order')
			specs.each do |s|
				s.display_order = i
				s.save
				i += 1
			end
		end
	end

end
