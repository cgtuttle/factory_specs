class Category < ActiveRecord::Base
	validates :code, :presence => true, :uniqueness => {:scope => :account_id}
	has_many :specs

	default_scope { where(:account_id => Account.current_id)}

	scope :active, where(:deleted => false)
	
	def reorder(new)
		old = self.id ? self.display_order : 0
		if new < old
			self.display_order = new
			self.save
			Category.where('display_order >= ? AND display_order <= ? AND id != ?', new, old, self.id).update_all("display_order = display_order + 1") 
		elsif new > old && old > 0
			self.display_order = new
			self.save
			Category.where('display_order >= ? AND display_order <= ? AND id != ?', old, new, self.id).update_all("display_order = display_order - 1")
		elsif old == 0
			Category.where('display_order >= ?', new).update_all("display_order = display_order + 1")
		end
		if old != new && old > 0
			i = 1
			categories = Category.order('display_order')
			categories.each do |c|
				c.display_order = i
				c.save
				i += 1
			end
		end
	end
	
end
