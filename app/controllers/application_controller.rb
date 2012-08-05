class ApplicationController < ActionController::Base
  protect_from_forgery

  layout "login"

  # Code used by CanCan to manage exception
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
end

