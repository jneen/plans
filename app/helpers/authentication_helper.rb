module AuthenticationHelper
  def current_account
    return Account.new if session[:account].blank?

    @current_account ||= Account.find_by_login(session[:account])
  end
end
