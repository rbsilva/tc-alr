class Admin::DataWarehouseController < BaseController

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
 
    ActiveRecord::Base.connection.tables.grep(/.*_fact$/).each do |table|
      @columns = {}
      ActiveRecord::Base.connection.columns(table).each do |column|
        values = ActiveRecord::Base.connection.execute("SELECT #{column.name} FROM #{table}")
        @columns.store(column.name, values)
      end

      @tables.store(table, @columns.dup)
    end
  end

end
