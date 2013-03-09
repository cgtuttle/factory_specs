class User < ActiveRecord::Base
	belongs_to :account, :inverse_of => :users
	accepts_nested_attributes_for :account
	validates :account, :presence => true
#  default_scope { where(:account_id => Account.current_id)}
  rolify

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :account_attributes

  after_create :assign_user_role

protected
  
  def assign_user_role
    account = self.account
    if account.users.count == 1
      add_role(:admin)
    end
  end

end
