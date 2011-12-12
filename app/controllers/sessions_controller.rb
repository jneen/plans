class SessionsController < ApplicationController
  def new
    render :layout => 'sparse'
  end

  def create
    account = Account.find_by_login(params[:login])
    
    if account && account.correct_password?(params[:password])
      login_and_redirect(account)
    else
      flash[:notice] = 'Incorrect username or password'
      redirect_to :action => :new
    end
  end

  def clear
    session.delete(:account)
    redirect_to new_session_path
  end

private
  def login_and_redirect(account)
    session[:account] = account.login
    redirect = if session[:redirect].present?
      session.delete(:redirect)
    else
      plan_path(account.login)
    end

    redirect_to redirect
  end
end
