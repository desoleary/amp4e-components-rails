module ApplicationHelper
  def rails_flash_to_bootstrap(type)
    case type.to_sym
      when :alert, :warn
        'alert-warning'
      when :error
        'alert-danger'
      when :info, :notice
        'alert-info'
      when :success
        'alert-success'
      else
        type.to_s
    end
  end
end
