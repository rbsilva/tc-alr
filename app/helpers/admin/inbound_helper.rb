module Admin::InboundHelper
  def inbound_table(inbound_file)
    html = '<table>'
    html += '<tr>'
    row = inbound_file['sheet'].first['cell'].first['row']

    header = true

    inbound_file['sheet'].first['cell'].each do |meta_data|
      if row != meta_data['row'] then
        html += '</tr><tr>'.html_safe
        row = meta_data['row']
        header = false
      end
      tag = header ? 'th' : 'td';
      html += "<#{tag}>#{meta_data['content']}</#{tag}>"
    end
    html += '</table>'

    html.html_safe
  end
end
