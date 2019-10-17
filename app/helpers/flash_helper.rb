module FlashHelper

  def show_flash_messages
    flash
      .map { |type, message| flash_message_html(type, message) }
      .join("\n").html_safe
  end

  def flash_message_html(type, message)
    "<script>toastr.#{converted_type(type)}(\"#{message}\");</script>".html_safe
  end

  def converted_type(type)
    return 'warning' if type == 'alert'
    return 'success' if type == 'notice'
  end
end
