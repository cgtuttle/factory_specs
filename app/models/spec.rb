class Spec < ActiveRecord::Base
	validates :code, :presence => true, :uniqueness => {:scope => :account_id}
	has_many :item_specs
	has_many :items, :through => :item_specs
	belongs_to :category

	default_scope { where(:account_id => Account.current_id)}
	
	def self.filtered(filter)
		Spec.where('code LIKE ?', filter).order('code') | Spec.where('code NOT LIKE ?', filter).order('code')
	end
	
	def reorder(new_order)
		old = self.id ? self.display_order : 0
		old ||= 0
		new_order ||= 0
		if new_order < old
			self.display_order = new_order
			self.save
			Spec.where('display_order >= ? AND display_order <= ? AND id != ?', new_order, old, self.id).update_all("display_order = display_order + 1") 
		elsif new_order > old && old > 0
			self.display_order = new_order
			self.save
			Spec.where('display_order >= ? AND display_order <= ? AND id != ?', old, new_order, self.id).update_all("display_order = display_order - 1")
		elsif old == 0
			specs = Spec.where('display_order >= ?', new_order).update_all("display_order = display_order + 1")
		end
		if Spec.count > 0
			if old != new_order && old > 0 || Spec.minimum(:display_order) > 1
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

end
