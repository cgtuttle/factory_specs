class ItemSpec < ActiveRecord::Base
	belongs_to :item
	belongs_to :spec
	belongs_to :test
	
	before_create :set_eff_date
	before_create :set_version
	
	def self.by_item(item_id)
		@item_specs = ItemSpec.joins(:spec => :category).where(:item_id => item_id).order('categories.display_order, s.display_order, i.eff_date DESC, i.version DESC')
	end
	
	def self.by_status(item, past, future)
			logger.debug "past -> #{past}, future -> #{future}"
			sql_string_current =
			"(SELECT i.*, s.*, 'current' as status, categories.display_order as cat_seq,
				s.display_order as spec_seq, i.eff_date as date_seq,
				i.version as ver_seq  
				FROM item_specs as i, specs as s, categories 
				WHERE i.spec_id = s.id
					AND s.category_id = categories.id
					AND	i.eff_date =        
					(SELECT max(eff_date)
						FROM item_specs A
						WHERE A.item_id = i.item_id
						AND A.spec_id = i.spec_id
					)
					AND i.version =
					(SELECT max(version)
					FROM item_specs B
						WHERE B.item_id = i.item_id
						AND B.spec_id = i.spec_id
					)
				AND i.item_id = #{item})"
		
		if past
			logger.debug "past true - past? -> #{past}"
			sql_string_past = 
			" UNION ALL 
				(SELECT i.*, s.*, 'history' as status, categories.display_order as cat_seq,
					s.display_order as spec_seq, i.eff_date as date_seq,
					i.version as ver_seq
				FROM item_specs as i, specs as s, categories 
				WHERE i.spec_id = s.id
					AND s.category_id = categories.id
					AND i.eff_date <= 
					(SELECT max(eff_date)
						FROM item_specs C
						WHERE C.item_id = i.item_id
						AND C.spec_id = i.spec_id
					)
					AND i.version <
					(SELECT max(version)
					FROM item_specs D
						WHERE D.item_id = i.item_id
						AND D.spec_id = i.spec_id
					)
				AND i.eff_date <= current_date
				AND i.item_id = #{item})"
		else
			logger.debug "past false - past? -> #{past}"
			sql_string_past = ""
		end
			
		if future
			logger.debug "future true - future? -> #{future}"
			sql_string_future =
			" UNION ALL
				(SELECT i.*, s.*, 'future' as status, categories.display_order as cat_seq,
					s.display_order as spec_seq, i.eff_date as date_seq,
					i.version as ver_seq
				FROM item_specs as i, specs as s, categories 
				WHERE i.spec_id = s.id
					AND s.category_id = categories.id 
				AND i.eff_date > current_date
				AND i.item_id = #{item})"
		else
			sql_string_future = ""
			logger.debug "future false - future? -> #{future}"
		end
				
			sql_string_order =	
			" ORDER BY cat_seq, spec_seq, date_seq DESC, ver_seq DESC"
		
		sql_string = "#{sql_string_current}#{sql_string_past}#{sql_string_future}#{sql_string_order}"
		logger.debug "sql_string -> #{sql_string}"
		ItemSpec.find_by_sql(sql_string)
	end
	
	def self.current(item)
		ItemSpec.order('eff_date DESC, version DESC').group('spec_id').where("item_id = ? and eff_date <= ?", item, Date.today).select("*, 'current' as status")
	end
	
	def self.past(item)
		current = ItemSpec.current(item)
		ItemSpec.where("id NOT IN (?) and item_id = ? and eff_date <= ?", current, item, Date.today).select("*, 'history' as status")
	end
	
	def self.future(item)
		ItemSpec.where("item_id = ? and eff_date > ?", item, Date.today).select("*, 'future' as status")
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
