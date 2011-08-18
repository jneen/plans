class ApplicationController < ActionController::Base
  protect_from_forgery
private
  def title_components
    @title_components ||= ['Plans']
  end

  def canonical_path
    url_for action: action_name, controller: controller_name
  end
end
