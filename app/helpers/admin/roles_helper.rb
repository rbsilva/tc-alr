module Admin::RolesHelper
  def areas
    begin
      field_name = "role[models][]"

      html = tag 'span'
      models.each do |model|
        cbx_id = "role_models_#{model.downcase}"
        cbx = check_box_tag field_name, model.downcase, model.downcase, :id => cbx_id
        html += label_tag cbx_id, h(model) + " " + h(cbx), :class => ' checkbox'
        html += tag 'br'
      end
      html += tag 'br'
      html
    rescue => e
      e
    end
  end
end
