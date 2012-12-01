class DataWarehouseMigrator < DataWarehouseDb
  def self.create_table_model(name, fields)
    connection.create_table name do |t|
      fields.each do |field|
        t.send(field.db_type, field.description)
      end

      t.timestamps
    end
  end

  def self.drop_table_model(name)
    connection.drop_table name
  end
end
