module LayoutHelper
  def submit_button(klass='')
    content_tag :div, class: 'btn-group' do
      content_tag :button,  '', class: "btn btn-submit btn-success #{klass}", type: 'submit' do
        concat content_tag :span, 'SAVE', class: 'mr-2'
        concat content_tag :span, '', class: 'fa fa-edit fa-lg float-right'
      end
    end
  end

  def highlight_button(klass='')
    content_tag :div, class: 'btn-group' do
      content_tag :button,  '', class: "btn btn-primary btn-orange btn-app  #{klass}", type: 'submit' do
        concat content_tag :span, 'HIGHLIGHT', class: 'mr-2'
        concat content_tag :span, '', class: 'fa fa-star fa-lg float-right'
      end
    end
  end


  def back_button
    content_tag :div, class: 'btn-group' do
      content_tag :button,  '', class: 'btn btn-primary btn-app' do
        concat content_tag :span, 'BACK', class: 'mr-2'
        concat content_tag :span, '', class: 'fa fa-arrow-left fa-lg float-right'
      end
    end
  end

  def delete_button
    content_tag :div, class: 'btn-group' do
      content_tag :button,  '', class: 'btn btn-danger' do
        concat content_tag :span, 'DELETE', class: 'mr-2'
        concat content_tag :span, '', class: 'fa fa-trash fa-lg float-right'
      end
    end
  end

  def show_button
    content_tag :div, class: 'btn-group' do
      content_tag :button,  '', class: 'btn btn-primary btn-app' do
        concat content_tag :span, 'SHOW', class: 'mr-2'
        concat content_tag :span, '', class: 'fa fa-eye fa-lg float-right'
      end
    end
  end



end
