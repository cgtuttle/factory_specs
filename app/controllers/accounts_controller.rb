class AccountsController < ApplicationController
  
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
end
