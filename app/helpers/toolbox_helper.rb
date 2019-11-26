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
end
