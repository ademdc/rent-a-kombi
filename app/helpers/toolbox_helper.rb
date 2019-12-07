module ToolboxHelper
  def message_icon(klass = '')
    content_tag :i, '', class: "fa fa-envelope #{klass}"
  end

  def info_icon(klass='')
    content_tag :i, '', class: "fa fa-info #{klass}"
  end

  def camera_icon(klass='')
    content_tag :i, '', class: "fa fa-camera-retro #{klass}"
  end

  def calendar_icon(klass='')
    content_tag :i, '', class: "fa fa-calendar #{klass}"
  end

  def upload_icon(klass='')
    content_tag :i, '', class: "fa fa-upload #{klass}"
  end

  def heart_icon(klass='')
    content_tag :i, '', class: "fa fa-heart #{klass}"
  end

  def car_icon(text='', klass='')
    icon = (content_tag :i, '', class: "fa fa-car #{klass}")
    "#{text} #{icon}".html_safe
  end

end
