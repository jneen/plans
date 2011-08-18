class PlansController < ApplicationController
  before_filter :find_account
  before_filter :protect, :only => [:edit, :update]

  include AuthenticationHelper

  def show
    title_components << "#{@account.login}'s Plan"
  end

  def edit
    title_components << "Edit #{@account.login}'s Plan"
  end

  def update
    @account.plan.update_attributes(params[:plan].slice(:contents))
    redirect_to plan_path(@account.login)
  end

private
  def protect
    redirect_to plan_path(@account.login) unless current_account == @account
  end

  def find_account
    @account = Account.find_by_login(params[:id])
  end
end
