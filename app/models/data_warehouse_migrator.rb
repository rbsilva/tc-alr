class DataWarehouseMigrator < DataWarehouseDb
  def self.create_table_model(name, fields)
    connection.create_table name do |t|
      fields.each do |field|
        if field.description.end_with? "_dimensions" then
          t.send(field.db_type, field.description.singularize)
        else
          t.send(field.db_type, field.description)
        end
      end

      t.timestamps
    end
  end

  def self.drop_table_model(name)
    connection.drop_table name
  end
end
