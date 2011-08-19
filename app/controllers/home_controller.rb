class HomeController < ApplicationController
  def index
    if current_account.logged_in?
      redirect_to plan_path(current_account.login)
    end
  end
end
