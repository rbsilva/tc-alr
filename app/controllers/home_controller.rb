class HomeController < ApplicationController
  before_filter :authenticate_user! #, :except => [:some_action_without_auth]

  caches_page :index

  def index
  end
end
