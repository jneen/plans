class AccountsController < ApplicationController
  include AuthenticationHelper

  before_filter :require_login, :only => [:edit, :update]

  def edit
    @account = current_account
  end

  def update
    password_attrs = {
      :password => params[:account][:password],
      :new_password => params[:new_password],
      :confirm_password => params[:confirm_password]
    }

    unless check_password_confirmation(current_account, password_attrs)
      flash[:notice] = 'Passwords did not match each other or our records.'
      redirect_to :action => :edit
      return
    end

    current_account.update_attributes(
      :password => password_attrs[:new_password],
      :theme => decide_theme(params)
    )

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
