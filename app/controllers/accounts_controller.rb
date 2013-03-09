class AccountsController < ApplicationController
#  load_and_authorize_resource
  
	def new
    @account = Account.new
    @account.users.build # build a blank user or the child form won't display
  end

  def create
    @account = Account.new(params[:account])
    if @account.save
      flash[:success] = "Account created"
      redirect_to accounts_path
    else
      render 'new'
    end
  end

  def edit
    @is_edit_form = true
  end

  def show
    
  end

end
