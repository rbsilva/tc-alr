class HomeController < ApplicationController

  def index
    I18n.locale = params[:locale]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fact }
    end
  end
  
end
