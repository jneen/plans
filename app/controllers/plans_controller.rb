class PlansController < ApplicationController
  before_filter :find_account
  before_filter :restrict_to_registered
  before_filter :restrict_to_owner, :only => [:edit, :update]

  include AuthenticationHelper

  def index
  end

  def show
    current_account.ping(@account)

    title_components << "#{@account.login}'s Plan"
  end

  def edit
    title_components << "Edit #{@account.login}'s Plan"
  end

  def update
    @account.plan.update_attributes(params[:plan].slice(:contents))
    redirect_to plan_path(@account.login)
  end

  def finger
    return if current_account == @account

    if current_account.auto_fingers.include? @account
      flash[:notice] = <<-notice.squish
        @#{@account.login} is already on your autofinger list.
      notice
    else
      current_account.auto_fingers << @account
      flash[:notice] = "@#{@account.login} has been added to your autofinger list"
    end

    redirect_to plan_path(@account.login)
  end

  def unfinger
    return if current_account == @account

    if current_account.auto_fingers.include? @account
      current_account.auto_fingers.delete(@account)
      flash[:notice] = <<-notice.squish
        @#{@account.login} has been removed from your autofinger list.
      notice
    else
      flash[:notice] = <<-notice.squish
        #{@account.handle} is not on your autofinger list.
      notice
    end

    redirect_to plan_path(@account.login)
  end

private
  def restrict_to_registered
    if current_account.guest?
      session[:redirect] = canonical_path
      redirect_to new_session_path
    end
  end

  def restrict_to_owner
    redirect_to plan_path(@account.login) unless current_account == @account
  end

  def find_account
    @account = Account.find_by_login(params[:id])
  end
end
