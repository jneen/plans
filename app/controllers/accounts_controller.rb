class AccountsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    @account = Account.new(params[:account])

    if @account.save
      # on your way
      set_current_account(@account)
      redirect_to plan_path(@account.login)
    else
      render :action => :new
    end
  end
end
