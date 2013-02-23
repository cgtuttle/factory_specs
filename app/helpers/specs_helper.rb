module SpecsHelper

	def active_categories
		Category.where(:deleted => false)
	end
end
