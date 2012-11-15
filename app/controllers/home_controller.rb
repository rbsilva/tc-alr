class HomeController < ApplicationController

  def index
    #I18n.locale = params[:locale]
    redirect_to  admin_dashboard_index_path
    #respond_to do |format|
      #format.html # new.html.erb
      #format.json { render json: @fact }
    #end
  end

end
