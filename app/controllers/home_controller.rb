class HomeController < ApplicationController

  before_filter :authenticate_user! #, :except => [:some_action_without_auth]

  layout "home"

  def index
  end
end

