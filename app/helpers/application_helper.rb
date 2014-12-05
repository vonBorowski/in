module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type.to_sym
      when :success
        "alert-success"
      when :error
        "alert-danger"
      when :alert
        "alert-warning"
      when :notice
        "alert-success"
      else
        flash_type.to_s
    end
  end

  def actions(resource)
    output = ''
    output << link_to(raw("#{fa_icon "eye"}"), resource, class: "btn btn-primary btn-outline")
    output << link_to(raw("#{fa_icon "pencil"}"), [:edit, resource], class: "btn btn-primary btn-outline")
    output << link_to(raw("#{fa_icon "trash"}"), resource, method: :delete, class: "btn btn-danger btn-outline", data: {confirm: "Tem certeza?"})
    output = content_tag(:div, output.html_safe, class: "btn-group")
    output.html_safe
  end
end
