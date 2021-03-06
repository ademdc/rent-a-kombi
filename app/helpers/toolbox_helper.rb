module ToolboxHelper
  def message_icon(klass = '')
    content_tag :i, '', class: "fa fa-envelope #{klass}"
  end

  def info_icon(klass='', title='')
    content_tag :i, '', class: "fa fa-info #{klass}", "data-toggle": "tooltip", 'title':title
  end

  # def camera_icon(klass='')
  #   content_tag :i, '', class: "fa fa-camera-retro #{klass}"
  # end

  def camera_icon(text='', klass='', tooltip='')
    icon = (content_tag :i, '', class: "fa fa-camera-retro #{klass}", 'data-toggle':'tooltip', title: tooltip)
    "#{text} #{icon}".html_safe
  end

  def info_circle_icon(text='', klass='', tooltip='')
    icon = (content_tag :i, '', class: "fa fa-info-circle #{klass}", 'data-toggle':'tooltip', title: tooltip)
    "#{text} #{icon}".html_safe
  end

  def money_icon(text='', klass='', tooltip='')
    icon = (content_tag :i, '', class: "fa fa-money-check-alt #{klass}", 'data-toggle':'tooltip', title: tooltip)
    "#{text} #{icon}".html_safe
  end

  def calendar_icon(text='', klass='', tooltip='')
    icon = (content_tag :i, '', class: "fa fa-calendar #{klass}", 'data-toggle':'tooltip', title: tooltip)
    "#{text} #{icon}".html_safe
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

  def warning_icon(klass='')
    content_tag :i, '', class: "fa fa-warning text-warning #{klass}"
  end

  def check_icon(text='', klass='')
    icon = (content_tag :i, '', class: "fa fa-check #{klass}")
    "#{text} #{icon}".html_safe
  end

  def trash_icon(text='', klass='')
    icon = (content_tag :i, '', class: "fa fa-trash #{klass}")
    "#{text} #{icon}".html_safe
  end

  def plus_icon(text='', klass='', tooltip='')
    icon = (content_tag :i, '', class: "fa fa-plus-circle #{klass}", 'data-toggle':'tooltip', title: tooltip)
    "#{text} #{icon}".html_safe
  end


end
