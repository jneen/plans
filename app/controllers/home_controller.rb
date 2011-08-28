class HomeController < ApplicationController
  def index
    if current_account.logged_in?
      redirect_to plan_path(current_account.login)
    else
      redirect_to new_session_path
    end
  end
end
