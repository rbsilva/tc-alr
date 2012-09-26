module Admin::InboundHelper
  def inbound_table(inbound_file)
    html = '<table>'
    html += '<tr>'
    row = inbound_file['sheet'].first['cell'].first['row']
    
    inbound_file['sheet'].first['cell'].each do |meta_data|
      if row != meta_data['row'] then
        html += '</tr><tr>'.html_safe
        row = meta_data['row']
      end
      html += "<td>#{meta_data['content']}</td>"
    end
    html += '</table>'
    html.html_safe
  end
end
