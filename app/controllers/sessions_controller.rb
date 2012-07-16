class SessionsController < ApplicationController
  before_filter :check_login, :only => [:new]
  def new
  end
  
  def create
    user = User.authenticate(params[:name], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      redirect_to root_url, :notice => "Invalid name or password"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
  
  private
  
  def check_login
    redirect_to root_url, :notice => "Already logged in!" unless !session[:user_id]
  end
end
