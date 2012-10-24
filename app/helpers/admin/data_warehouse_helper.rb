module Admin::DataWarehouseHelper

  def data_warehouse_table(fact)
    html = '<table class="data_warehouse_table">'
    html += '<thead><tr>'
    fact.fields.each do |column|
      html += "<th id='#{column.id}'>#{column.description}</th>"
      if column.db_type == 'references' then
        DataTable.where(:name => column.description).first.fields.each do |d_column|
          html += "<th id='#{d_column.id}'>#{d_column.description}</th>"
        end
      end
    end
    html += '</tr></thead><tbody>'
    html += generate_tbody(fact)
    html += '</tbody></table>'
    html.html_safe
  end

  private
    def generate_tbody(table)
      html = ''
      eval(table.name.camelize).all.each do |data_table|
        html += '<tr>'
        html += generate_td(table, data_table)
        html += ' </tr>'
      end
      html
    end

    def generate_td(table, data_table)
      html = ''
      table.fields.each do |value|
        method = value.description
        if value.db_type == 'references' then
          d_table = DataTable.where(:name => method).first
          eval(d_table.name.camelize).all.each do |d_data_table|
            html += generate_td(d_table, d_data_table)
          end
          method += '_id'
        end
        html += "<td>#{data_table.send method.to_sym}</td>"
      end
      html
    end
end
