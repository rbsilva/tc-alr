class DataWarehouse
  attr_accessor :tables

  def self.dimensions
    find_table
  end

  def self.facts
    find_table 'fact'
  end

  def self.load(fact, data, headers)
    sql = ''

    data.zip(headers).each do |datum, header|
      if header.match(/.*_dim_.*$/)
        table = header.scan(/.*_dim_(.*)$/).last.first + '_dimension'
        column = header.scan(/(.*)_dim_.*$/).last.first
      else
        table = fact
        column = "#{header}, contas_id"
        datum = "#{datum}"
      end

      sql = "INSERT INTO #{table}(#{column}) VALUES ('#{datum}', 1)"

      ActiveRecord::Base.connection.execute(sql)
    end

    true
  rescue
    false
  end

  private

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
