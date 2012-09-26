module Admin::DataWarehouseHelper

  def data_warehouse_table(table, data)
    html = table.to_s
    html += '<table>'
    html += ' <tr>'
    data[0].each do |column|
      html += "<th>#{column}</th>"
    end
    html += ' </tr>'
    data[1].each do |values|
      html += ' <tr>'
      values.each do |value|
        html += "<td>#{value[1]}</td>"
      end
      html += ' </tr>'
    end
    html += '</table>'
    html.html_safe
  end
end
