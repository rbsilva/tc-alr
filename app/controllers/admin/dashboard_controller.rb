class Admin::DashboardController < ApplicationController
  before_filter :authenticate_user! #, :except => [:some_action_without_auth]
  before_filter :get_user
  before_filter :accessible_roles
  load_and_authorize_resource

  private
  include Utils
end
