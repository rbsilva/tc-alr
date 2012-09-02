module Admin::InboundHelper

  def inbound_table(inbound_file)
    html = '<table>'
    html += '<tr>'
    row = 1
    inbound_file.each_value do |meta_data|
      if row != meta_data['row'] then
        html += '</tr><tr>'.html_safe
        row = meta_data['row']
      end
      html += "<td>#{meta_data['value']}</td>"
    end
    html += '</table>'
    html.html_safe
  end
end
