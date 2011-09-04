class AccountsController < ApplicationController
  include AuthenticationHelper

  before_filter :require_login, :only => [:edit, :update]

  def edit
    @account = current_account
    title_components << "Edit #{@account.login}'s account"
  end

  def update
    attrs = {}

    password_attrs = {
      :password => params[:account][:password],
      :new_password => params[:new_password],
      :confirm_password => params[:confirm_password]
    }

    if (
      params[:new_password].present? &&
      check_password_confirmation(current_account, password_attrs)
    ) then
      attrs[:password] = params[:new_password]
    elsif params[:new_password].present?
      flash[:notice] = 'Passwords did not match each other or our records.'
      redirect_to :action => :edit
      return
    end

    attrs[:theme] = decide_theme(params)

    current_account.update_attributes(attrs)

    if current_account.save
      flash[:notice] = 'Successfully updated account'
      redirect_to plan_url(current_account.login)
    else
      redirect_to :action => :edit
    end
  end

private
  def check_password_confirmation(account, attrs)
    return true if current_account.temporary_password?
    return true unless attrs[:new_password].present?
    return false unless attrs[:password].present?
    return false unless attrs[:confirm_password].present?
    return false unless current_account.correct_password?(attrs[:password])

    return attrs[:new_password] == attrs[:confirm_password]
  end

  def decide_theme(p={})
    if p[:theme] == 'other'
      p[:theme_other]
    else
      p[:theme]
    end
  end
end
