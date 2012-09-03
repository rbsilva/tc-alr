class Admin::DataWarehouseController < ApplicationController
  before_filter :authenticate_user! #, :except => [:some_action_without_auth]
  before_filter :get_user
  before_filter :accessible_roles
  load_and_authorize_resource

  def list
    @tables = {}
    ActiveRecord::Base.connection.tables.grep(/.*_dimension$/).each do |table|
      @columns = {}
      ActiveRecord::Base.connection.columns(table).each do |column|
        values = ActiveRecord::Base.connection.execute("SELECT #{column.name} FROM #{table}")
        @columns.store(column.name, values)
      end

      @tables.store(table, @columns.dup)
    end
  end

  private
  include Utils
end
