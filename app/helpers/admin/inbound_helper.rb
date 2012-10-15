module Admin::InboundHelper
  def inbound_table(inbound_file)
    html = '<table class="inbound_table">'
    html += '<thead><tr>'
    row = inbound_file['sheet'].first['cell'].first['row']

    header = true

    inbound_file['sheet'].first['cell'].each do |meta_data|
      if row != meta_data['row'] then
        if header then
          html += '</tr></thead><tbody>'
        else
          html += '</tr>'
        end
        html += '<tr>'.html_safe
        row = meta_data['row']
        header = false
      end
      tag = header ? 'th' : 'td';
      html += "<#{tag} type='#{meta_data['type']}'>#{meta_data['content']}</#{tag}>"
    end
    html += '</tbody></table>'

    html.html_safe
  end
end
