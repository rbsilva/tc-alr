module Admin::DataWarehouseHelper

  def data_warehouse_table(table, data)
    html = '<table class="data_warehouse_table">'
    html += '<thead><tr>'
    data[0].each do |column|
      html += "<th>#{column}</th>"
    end
    html += '</tr></thead><tbody>'
    data[1].each do |values|
      html += '<tr>'
      values.each do |value|
        html += "<td>#{value[1]}</td>"
      end
      html += ' </tr>'
    end
    html += '</tbody></table>'
    html.html_safe
  end
end
