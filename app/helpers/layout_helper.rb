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

end
