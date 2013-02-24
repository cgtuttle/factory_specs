class Account < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true
  has_many :users, :dependent => :destroy, :inverse_of => :account
  accepts_nested_attributes_for :users
  attr_accessible :name, :users_attributes
  resourcify

 def self.current_id=(id)
 	Thread.current[:account_id] = id
 end

 def self.current_id
 	Thread.current[:account_id]
 end

end
