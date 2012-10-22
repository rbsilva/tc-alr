class DataWarehouse
  attr_accessor :tables

  def self.dimensions
    find_table
  end

  def self.facts
    find_table 'fact'
  end

  def self.load(fact, data, headers, types)
    sql = ''
    operation = {}

    headers.uniq.each do |header|
      if header.match(/.*_dim_.*$/) then
        table = header.scan(/.*_dim_(.*)$/).last.first + '_dimension'
        column = header.scan(/(.*)_dim_.*$/).last.first
      else
        table = fact
        column = header
      end

      unless header.match(/.*_id$/) || header.match(/^id$/) then
        if operation[table].nil? then
          operation[table] = {column => []}
        else
          operation[table].store(column, [])
        end
      end
    end

    data.zip(headers, types).each do |datum, header, type|
      if header.match(/.*_dim_.*$/) then
        table = header.scan(/.*_dim_(.*)$/).last.first + '_dimension'
        column = header.scan(/(.*)_dim_.*$/).last.first
      else
        table = fact
        column = header
      end

      unless header.match(/.*_id$/) || header.match(/^id$/) then
        if type == 'string' || type == 'datetime' then
          datum = "'#{datum}'"
        end
        operation[table][column] << datum
      end
    end

    indexes = {}

    operation.each_pair do |table, columns|
      if table.match(/.*_dimension$/) then
        last_id = insert_load table, columns

        indexes.store("#{table.scan(/(.*)_dimension$/).last.first}_id", last_id)
      end
    end

    last_id = insert_load fact, operation[fact]

    sql = "UPDATE #{fact} SET "
    backup_sql = sql

    sets = []

    indexes.each_pair do |column,values|
      values.zip(last_id).each do |value, id|
        sets << "#{column}=#{value}"

        sql += sets.join(',')
        sql += " WHERE id = #{id}"

        ActiveRecord::Base.connection.execute(sql)

        sql = backup_sql
        sets = []
      end
    end

    true
  rescue
   ActiveRecord::Base.logger.fatal $!
   false
  end

  private

    def self.insert_load(table, columns)
      sql = "INSERT INTO #{table} ("
      values = []

      sql += "#{columns.keys.join(',')}) VALUES "

      columns.each_value do |data|
        values << data
      end

      aux_values = values

      values = aux_values.first

      aux_values.each do |data|
        unless aux_values.first == data then
          values = values.zip data
        end
      end

      last_id = []

      backup_sql = sql

      values.each do |value|
        begin
          sql += "(#{value.join(',')})"
        rescue
          sql += "(#{value})"
        end

        ActiveRecord::Base.connection.execute(sql)

        sql = backup_sql

        last_id << ActiveRecord::Base.connection.execute("SELECT currval('#{table}_seq')").first["currval"]
      end

      last_id
    end

    def self.find_table(type='dimension', id='.*')
      tables = {}
      ActiveRecord::Base.connection.tables.grep(/#{id}_#{type}$/).each do |table|
        columns = []
        joins = {}
        joins_columns = []
        ActiveRecord::Base.connection.columns(table).each do |column|
          columns << column.name
          if column.name.match(/.*_id$/) then
            ref_table = column.name.scan(/(.*)_id$/).last.first

            ActiveRecord::Base.connection.columns("#{ref_table}_dimension").each do |ref_column|
              joins_columns << "#{ref_column.name}_dim_#{ref_table}" unless ref_column.name == 'id'
            end

            joins.store(column.name, ref_table)
          end
        end

        fields = "#{table}.*"
        inner = ""

        columns += joins_columns

        joins.each_pair do |foreign_key, ref_table|

          ActiveRecord::Base.connection.columns(ref_table+'_dimension').each do |ref_column|
            fields += ", #{ref_table}_dimension.#{ref_column.name}" unless ref_column.name == 'id'
          end

          inner += " INNER JOIN #{ref_table}_dimension ON #{ref_table}_dimension.id = #{table}.#{foreign_key}"
        end

        sql = "SELECT #{fields} FROM #{table} #{inner}"

        values = ActiveRecord::Base.connection.select_all(sql).to_a
        tables.store(table, [columns.dup, values.dup])
      end
      tables
    end
end
