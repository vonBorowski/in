module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type.to_sym
      when :success
        "alert-success"
      when :error
        "alert-danger"
      when :alert
        "alert-danger"
      when :notice
        "alert-success"
      else
        flash_type.to_s
    end
  end

  def actions(resource)
    content_tag(:div, class: "btn-group") do
      concat link_to(raw("#{fa_icon "pencil"}"), [:edit, resource], class: "btn btn-primary btn-outline", title: "Editar")
      concat link_to(raw("#{fa_icon "trash"}"), resource, method: :delete, class: "btn btn-danger btn-outline", data: {confirm: "Tem certeza?"}, title: "Remover")
    end
  end

  def ibox(options = {})
    ibox_class = "ibox float-e-margins"
    ibox_class << " collapsed border-bottom" if options[:collapsed] == true
    content_tag(:div, class: ibox_class) do
      if options[:title].present?
        content_tag(:div, class: "ibox-title") do
          content_tag(:h5, options[:title]) +
          content_tag(:div, class: "ibox-tools") do
            if options[:collapsed].blank?
              content_tag(:a, raw("#{fa_icon "chevron-up"}"), class: "collapse-link")
            else
              content_tag(:a, raw("#{fa_icon "chevron-up"}"), class: "collapse-link") if options[:collapsed] == false
              content_tag(:a, raw("#{fa_icon "chevron-down"}"), class: "collapse-link") if options[:collapsed] == true
            end
          end
        end +
        content_tag(:div, class: options[:content_class] || 'ibox-content') do
          yield
        end
      else
        content_tag(:div, class: options[:content_class] || 'ibox-content') do
          yield
        end
      end
    end
  end
end