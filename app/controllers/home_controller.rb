class HomeController < ApplicationController
  before_filter :authenticate_user! #, :except => [:some_action_without_auth]
  before_filter :get_user, :only => [:index, :new, :edit]

  caches_page :index

  def index
    begin
      I18n.locale = params[:locale]
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @fact }
      end
    rescue
      logger.fatal $!
      logger.fatal $!.annoted_source_code
    end
  end

  private
  include Utils
end
