module Admin::RolesHelper
  def areas(role)
    begin
      field_name = "role[models][]"

      html = tag 'span'
      models.each do |model|
        cbx_id = "role_models_#{model.underscore}"
        cbx = check_box_tag field_name, model.underscore, role_has_model?(role, model), :id => cbx_id
        html += label_tag cbx_id, h(model) + " " + h(cbx), :class => ' checkbox'
        html += tag 'br'
      end
      html += tag 'br'
      html
    rescue => e
      e
    end
  end

  private
  def role_has_model?(role, model)
    role.models.split(',').include?(model.underscore) unless role.models.nil?
  end
end
