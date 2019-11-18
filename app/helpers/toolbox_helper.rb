module ToolboxHelper
  def message_icon(klass = '')
    content_tag :i, '', class: "fa fa-envelope #{klass}"
  end
end