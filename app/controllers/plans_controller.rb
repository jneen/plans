class PlansController < ApplicationController
  before_filter :find_account
  before_filter :restrict_to_registered
  before_filter :restrict_to_owner, :only => [:edit, :update, :preview]

  include AuthenticationHelper

  def index
  end

  def show
    current_account.view(@account)

    title_components << "#{@account.login}'s Plan"
  end

  def edit
    title_components << "Edit #{@account.login}'s Plan"
  end

  def update
    @account.plan.update_attributes(params[:plan].slice(:contents))
    redirect_to plan_path(@account.login)
  end

  # ajax action for the fancy preview
  def preview
    contents = Plan.filter!(params[:contents])
    render :text => contents, :content_type => 'text/html'
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
