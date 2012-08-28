class Class
  def extend?(_class)
    not superclass.nil? and ( superclass == _class or superclass.extend? _class )
  end
end

module ApplicationHelper
  def get_time(time='')
    if time.empty? then
      I18n.localize(Time.now)
    else
      I18n.localize(Time.parse(time))
    end
  end

  def models
    models = %w(User Role RawFile)
  end

  def habtm_checkboxes(obj, column, assignment_objects, assignment_object_display_column, label_css_class)
    obj_to_s = obj.class.to_s.split("::").last.underscore
    field_name = "#{obj_to_s}[#{column}][]"

    html = hidden_field_tag(field_name, "")
    assignment_objects.each do |assignment_obj|
      cbx_id = "#{obj_to_s}_#{column}_#{assignment_obj.id}"
      cbx = check_box_tag field_name, assignment_obj.id, obj.send(column).include?(assignment_obj.id), :id => cbx_id
      html += label_tag cbx_id, h(assignment_obj.send(assignment_object_display_column)) + " " + h(cbx), :class => label_css_class + ' checkbox'
      html += tag 'br'
    end
    html += tag 'br'
    html
  end
end
