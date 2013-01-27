class Item < ActiveRecord::Base
	validates :code, :presence => true, :uniqueness => {:scope => :account_id}
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
				Item.find(id)
			else
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

	def available_specs
		sql_string_used_specs = "
			SELECT a.*
			FROM
				((
				SELECT spec_id, MAX(version) as ver
				FROM item_specs
				WHERE item_id = #{self.id}					
				GROUP BY spec_id) AS y
			INNER JOIN
				(
				SELECT *
				FROM item_specs
				WHERE item_id = #{self.id}
				AND deleted = false) AS z
			ON y.spec_id = z.spec_id
			AND y.ver = z.version)
			INNER JOIN
				(
				SELECT *
				FROM specs) AS a
			ON a.id = z.spec_id
			"

		@used_specs = Spec.find_by_sql(sql_string_used_specs)
		if @used_specs.empty?
			Spec.all
		else
			Spec.where('id NOT IN (?)', @used_specs)
		end

	end

end
