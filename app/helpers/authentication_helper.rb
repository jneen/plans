module AuthenticationHelper
  def require_login
    redirect_to new_session_path if current_account.guest?
  end

  def current_account
    return Account.new if session[:account].blank?

    @current_account ||= Account.find_by_login(session[:account]) || Account.new
  end

  def set_current_account(account)
    session[:account] = account.login
    @current_account = account
  end
end
