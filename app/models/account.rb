class Account < ActiveRecord::Base
  has_many :users, :dependent => :destroy, :inverse_of => :account
  accepts_nested_attributes_for :users
  attr_accessible :name, :users_attributes
end
