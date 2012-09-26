class BaseController < ApplicationController
  before_filter :authenticate_user! #, :except => [:some_action_without_auth]
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  before_filter :get_user, :only => [:index, :new, :edit]
  load_and_authorize_resource :only => [:index, :show, :new, :destroy, :edit, :update]

  private
    # Get roles accessible by the current user
    def accessible_roles
      @accessible_roles = Role.accessible_by(current_ability, :read)
    end

    # Make the current user object available to views
    def get_user
      @current_user = current_user
    end
end
