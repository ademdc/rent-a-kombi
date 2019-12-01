module LayoutHelper
  def submit_button(klass='')
    content_tag :div, class: 'btn-group' do
      content_tag :button,  '', class: "btn btn-submit btn-success #{klass}", type: 'submit' do
        concat content_tag :span, 'SAVE', class: 'mr-2'
        concat content_tag :span, '', class: 'fa fa-edit fa-lg float-right'
      end
    end
  end

  def navigation_button(text, url, klass='', http_method='GET')
    content_tag :div, class: 'btn-group' do
      link_to url, method: http_method do
        content_tag :button,  '', class: "btn btn-primary btn-app #{klass}" do
          concat content_tag :span, text.to_s.upcase, class: 'mr-2'
          concat content_tag :span, '', class: 'fa fa-star fa-lg float-right'
        end
      end
    end
  end


  def back_button
    content_tag :div, class: 'btn-group' do
      link_to 'javascript:history.back()' do
        content_tag :button,  '', class: 'btn btn-primary btn-app', type: 'button' do
          concat content_tag :span, 'BACK', class: 'mr-2'
          concat content_tag :span, '', class: 'fa fa-arrow-left fa-lg float-right'
        end
      end
    end
  end

  def delete_button(url)
    content_tag :div, class: 'btn-group' do
      link_to url, data: { confirm: 'Are you sure you want to delete resource?' }, method: :delete  do
        content_tag :button,  '', class: 'btn btn-danger js-delete' do
          concat content_tag :span, 'DELETE', class: 'mr-2'
          concat content_tag :span, '', class: 'fa fa-trash fa-lg float-right'
        end
      end
    end
  end

  def navbar_item(url, name, current_user=nil, link_klass='')
    content_tag :li, class: "nav-item" do
      concat link_to t("navigation.#{name.to_s}"), url, class: "nav-link #{link_klass}"
      concat content_tag :span, current_user&.unread_messages, class: 'button__badge' if current_user&.unread_messages.try(:present?)
    end
  end

  def dropdown_navbar_item(title, title_class, &block)
    content_tag :li, class: 'dropdown' do
      concat (content_tag :div, class: 'dropdown-toggle', 'data-toggle': 'dropdown' do
        content_tag :span, class: "#{title_class}" do
          title
        end
      end)
      concat (content_tag :div, class: 'dropdown-menu dropdown-menu-right' do
        block.call
      end)
    end
  end

  def locale_selector
    I18n.available_locales.map do |locale|
      content_tag :div, class: 'dropdown-items' do
        concat inline_svg("countries/#{locale}.svg", class: 'country-icon')
        concat link_to t("languages.#{locale}"), locale_path(locale: locale), class: 'dropdown-item d-inline'
      end
    end.join("").html_safe
  end

end
