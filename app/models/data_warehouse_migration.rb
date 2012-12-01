class DataWarehouseMigration < ActiveRecord::Migration
  def self.connection=(model_connection)
    connection = model_connection
  end
end 
