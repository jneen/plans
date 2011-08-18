class PlansController < ApplicationController
  before_filter :find_account

  def show
  end

  def edit
  end

  def update
    @account.plan.update_attributes(params[:plan].slice(:contents))
    redirect_to plan_path(@account.login)
  end

private
  def find_account
    @account = Account.find_by_login(params[:id])
  end
end
