module Admin::ReportsHelper
  def report_show_fields(fields)
    fields_descriptions = []
    fields.split(',').each do |field|
      field = Field.find(field)
      fields_descriptions << field.description
    end
    fields_descriptions.join(',')
  end

  def report_headers(report)
    tr = ''
    report.fields.split(',').each do |field|
      field = Field.find(field)
      tr += "<th>#{field.description}</th>"
    end
    tr.html_safe
  # rescue
  #   ''
  end

  def report_data(report)
    html = ''
    fields = report.fields.split(',')
    lines = []

    fields.each_with_index do |field, i|
      field = Field.find(field)

      begin_tr = '<tr>' if i == 0
      end_tr = '</tr>' if fields.length == i

      eval(field.data_table.name.camelize).limit(10).each_with_index do |fact, j|
        lines[j] = '' if lines[j].nil?
        lines[j] += "#{begin_tr}<td style='color: black;'>#{fact.send(field.description.to_sym)}</td>#{end_tr}"
      end
    end
    lines.each do |line|
      html += line
    end
    html.html_safe
  # rescue
  #   ''
  end
end
